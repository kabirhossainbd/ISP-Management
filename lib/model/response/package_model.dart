import 'package:isp_management/service/helper/sql_helper.dart';

class PackageModel {
  int? id;
  String? name;
  String? packageName;
  int? price;

  PackageModel({this.id, this.name, this.packageName, this.price});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_PACKAGE_NAME: packageName,
      DatabaseProvider.COLUMN_PRICE: price
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  PackageModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    packageName = map[DatabaseProvider.COLUMN_PACKAGE_NAME];
    price = map[DatabaseProvider.COLUMN_PRICE];
  }
}
