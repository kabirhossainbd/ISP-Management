
import 'package:isp_management/model/response/package_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_PACKAGE = "package";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_PACKAGE_NAME = "packageName";
  static const String COLUMN_PRICE = "price";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  Database? _database;

  Future<Database> get database async {
    print("database getter called");
    if (_database != null) {
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'pacDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating food table");


        await database.execute(
          "CREATE TABLE $TABLE_PACKAGE ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NAME TEXT,"
              "$COLUMN_PACKAGE_NAME TEXT,"
              "$COLUMN_PRICE INTEGER"
              ")",
        );
      },
    );
  }

  Future<List<PackageModel>> getPackageList() async {
    final db = await database;

    String rawQuery = "SELECT * FROM $TABLE_PACKAGE;";
    var packages = await db.rawQuery(rawQuery);
    // var packages = await db.query(TABLE_PACKAGE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_PRICE]);
    List<PackageModel> packageList = [];
    for (var currentFood in packages) {PackageModel food = PackageModel.fromMap(currentFood);
    packageList.add(food);
    }

    print('-------->><<<<${packageList}');

    return packageList;
  }


  Future<List<PackageModel>> searchQuery(String query) async {
    final db = await database;

    String rawQuery = "SELECT * FROM $TABLE_PACKAGE WHERE $COLUMN_NAME LIKE '$query%';";
    var packages = await db.rawQuery(rawQuery);

    // var packages = await db.query(TABLE_PACKAGE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_PRICE]);
    List<PackageModel> packageList = [];
    for (var currentFood in packages) {PackageModel food = PackageModel.fromMap(currentFood);
    packageList.add(food);
    }


    return packageList;
  }

  Future<PackageModel> insert(PackageModel food) async {
    final db = await database;
    // food.id = await db.insert(TABLE_PACKAGE, food.toMap());
    String rawInsertData  = 'INSERT INTO $TABLE_PACKAGE ($COLUMN_NAME, $COLUMN_PACKAGE_NAME, $COLUMN_PRICE) VALUES (?,?,?);';
    food.id = await db.rawInsert(rawInsertData, [food.name, food.packageName, food.price]);
    return food;
  }


  Future<int> delete(int id) async {
    final db = await database;

    String rawDelete = 'DELETE FROM $TABLE_PACKAGE where id=?';
    return await db.rawDelete(rawDelete, [id]);
    // return await db.delete(
    //   TABLE_PACKAGE,
    //   where: "id = ?",
    //   whereArgs: [id],
    // );
  }

  Future<int> update(PackageModel package) async {
    final db = await database;

    String rawUpdate = 'UPDATE $TABLE_PACKAGE SET $COLUMN_NAME=?, $COLUMN_PACKAGE_NAME=?, $COLUMN_PRICE=? WHERE $COLUMN_ID=?';
    return await db.rawUpdate(rawUpdate, [package.name, package.packageName, package.price, package.id]);
    // return await db.update(
    //   TABLE_PACKAGE,
    //   package.toMap(),
    //   where: "id = ?",
    //   whereArgs: [package.id],
    // );
  }
  Future<List<PackageModel>> sortPackageList(bool ascending, bool price) async {
    final db = await database;

    String rawQuery = 'SELECT * FROM $TABLE_PACKAGE ORDER BY ${price ? COLUMN_PRICE : COLUMN_NAME} ${ascending ? 'ASC' : 'DESC'};';
    print('VVVVVVVVVVVVVVVVVVVVVVVVVV $rawQuery');
    var packages = await db.rawQuery(rawQuery);
    // var foods = await db.query(TABLE_PACKAGE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_PRICE]);
    List<PackageModel> packageList = [];
    for (var currentFood in packages) {PackageModel food = PackageModel.fromMap(currentFood);
    packageList.add(food);
    }


    return packageList;
  }


  Future<Database> close() async{
    return await db.close();
  }

}
