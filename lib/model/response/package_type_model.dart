class PackageTypeModel {
  int? id;
  String? leaveType;

  PackageTypeModel({this.id, this.leaveType});

  PackageTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['clientType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientType'] = leaveType;
    return data;
  }
}
