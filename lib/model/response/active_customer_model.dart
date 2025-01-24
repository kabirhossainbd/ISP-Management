class ActiveCustomerModel {
  int? id;
  String? name;
  String? email;
  String? photo;
  int? phone;
  bool? isActive;
  String? amount;
  int? mbps;
  String? date;
  String? dueDate;
  String? address;

  ActiveCustomerModel({this.id, this.name, this.email, this.photo, this.phone, this.isActive, this.amount = '', this.mbps, this.date = '', this.dueDate = '', this.address});

  ActiveCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['isActive'] = isActive;
    return data;
  }
}
