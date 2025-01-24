import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/response/package_type_model.dart';

class PackageRepo {

  Future<Response> getPackageTypeList(BuildContext context) async {
    try {
      List<PackageTypeModel> clientTypeList = [
        PackageTypeModel(id: 0, leaveType: 'Economic'),
        PackageTypeModel(id: 1, leaveType: 'Basic'),
        PackageTypeModel(id: 2, leaveType: 'Family'),
        PackageTypeModel(id: 3, leaveType: 'Bachelor'),
        PackageTypeModel(id: 4, leaveType: 'Fast'),
        PackageTypeModel(id: 5, leaveType: 'Super Fast'),
      ];
      Response response = Response(body: clientTypeList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(statusCode: 404, statusText: 'Item data not found');
    }
  }



  Future<Response> getPackageNameList(BuildContext context) async {
    try {
      List<PackageTypeModel> clientTypeList = [
        PackageTypeModel(id: 0, leaveType: '2Mbps'),
        PackageTypeModel(id: 1, leaveType: '5Mbps'),
        PackageTypeModel(id: 2, leaveType: '8Mbps'),
        PackageTypeModel(id: 3, leaveType: '10Mbps'),
        PackageTypeModel(id: 4, leaveType: '15Mbps'),
        PackageTypeModel(id: 5, leaveType: '20Mbps'),
      ];
      Response response = Response(body: clientTypeList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(statusCode: 404, statusText: 'Item data not found');
    }
  }
}