
import 'package:isp_management/service/helper/user_helper.dart';

class CustomerModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? type;

  CustomerModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.type});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_PACKAGE_NAME: type,
      DatabaseProvider.COLUMN_EMAIL: email,
      DatabaseProvider.COLUMN_NUMBER: phone,
      DatabaseProvider.COLUMN_ADDRESS: address,
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  CustomerModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    type = map[DatabaseProvider.COLUMN_PACKAGE_NAME];
    email = map[DatabaseProvider.COLUMN_EMAIL];
    phone = map[DatabaseProvider.COLUMN_NUMBER];
    address = map[DatabaseProvider.COLUMN_ADDRESS];
  }
}
