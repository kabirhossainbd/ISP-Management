import 'package:isp_management/model/response/customer_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_USER = "user";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_PACKAGE_NAME = "packageName";
  static const String COLUMN_EMAIL = "email";
  static const String COLUMN_NUMBER = "number";
  static const String COLUMN_ADDRESS = "address";

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
      join(dbPath, 'customDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating food table");

        await database.execute(
          "CREATE TABLE $TABLE_USER ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NAME TEXT,"
              "$COLUMN_PACKAGE_NAME TEXT,"
              "$COLUMN_EMAIL TEXT,"
              "$COLUMN_NUMBER TEXT,"
              "$COLUMN_ADDRESS TEXT"
              ")",
        );
      },
    );
  }

  Future<List<CustomerModel>> getCustomerList() async {
    final db = await database;

    var customers = await db.query(TABLE_USER, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_EMAIL, COLUMN_NUMBER, COLUMN_ADDRESS]);
    List<CustomerModel> customerList = [];
    for (var currentFood in customers) {CustomerModel customerModel = CustomerModel.fromMap(currentFood);
    customerList.add(customerModel);
    }

    return customerList;
  }


  Future<List<CustomerModel>> searchQuery(String query) async {
    final db = await database;

    String rawQuery = "SELECT * FROM $TABLE_USER WHERE $COLUMN_NAME LIKE '$query%';";
    var packages = await db.rawQuery(rawQuery);

    // var packages = await db.query(TABLE_PACKAGE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_PRICE]);
    List<CustomerModel> customerList = [];
    packages.forEach((currentFood) {CustomerModel food = CustomerModel.fromMap(currentFood);
    customerList.add(food);
    });


    return customerList;
  }


  Future<List<CustomerModel>> sortPackageList(bool ascending) async {
    final db = await database;
    String rawQuery = 'SELECT * FROM $TABLE_USER ORDER BY $COLUMN_NAME ${ascending ? 'ASC' : 'DESC'};';
    var packages = await db.rawQuery(rawQuery);
    // var foods = await db.query(TABLE_PACKAGE, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_PACKAGE_NAME, COLUMN_PRICE]);
    List<CustomerModel> customerList = [];
    for (var currentFood in packages) {CustomerModel food = CustomerModel.fromMap(currentFood);
    customerList.add(food);
    }


    return customerList;
  }

  Future<CustomerModel> insert(CustomerModel customerModel) async {
    final db = await database;
    customerModel.id = await db.insert(TABLE_USER, customerModel.toMap());
    return customerModel;
  }


  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_USER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(CustomerModel customerModel) async {
    final db = await database;

    return await db.update(
      TABLE_USER,
      customerModel.toMap(),
      where: "id = ?",
      whereArgs: [customerModel.id],
    );
  }

  Future<Database> close() async{
    return await db.close();
  }

}
