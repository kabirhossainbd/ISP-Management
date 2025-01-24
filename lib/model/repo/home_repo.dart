import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/response/home_model.dart';
import 'package:isp_management/src/data/datasource/remote/http_client.dart';
import 'package:isp_management/utils/my_image.dart';


class HomeRequest {
  final ApiClient apiSource;
  HomeRequest({required this.apiSource});


  Future<Response> getItemList() async {
    try {
      List<ItemModel> itemList = [
        ItemModel(id: 0, name: "New Customers",amount: "324242", image: MyImage.newCustomer, bgColor: const Color(0xFFDE7AA1), itemColor: const Color(0xFFD55687)),
        ItemModel(id: 1, name: "Active Customers", amount: "646464", image: MyImage.activeCustomer, bgColor: const Color(0xFF6986D4), itemColor: const Color(0xFF4366C5)),
        ItemModel(id: 2, name: "All customer list",amount: "22221", image: MyImage.allCustomer,  bgColor: const Color(0xFF5CC7A4), itemColor: const Color(0xFF32A981)),
        ItemModel(id: 3, name: "Due Payment", amount: "967564",image: MyImage.duePayment,  bgColor: const Color(0xFF61A3D0), itemColor: const Color(0xFF3985B6)),
        ItemModel(id: 4, name: "Package List",amount: "213123", image: MyImage.packageList,  bgColor: const Color(0xFFA983F0), itemColor: const Color(0xFF9365E7)),
        ItemModel(id: 5, name: "Support request",amount: "10", image: MyImage.supportRequest,  bgColor: const Color(0xFFBD9187), itemColor: const Color(0xFFA97465)),
        ItemModel(id: 6, name: "Transaction history",amount: "100", image: MyImage.totalEarning,  bgColor: const Color(0xFFBD9187), itemColor: const Color(0xFFA97465)),
        ItemModel(id: 7, name: "Employee List",amount: "30", image: MyImage.employeeList,  bgColor: const Color(0xFFBD9187), itemColor: const Color(0xFFA97465)),
      ];
      Response response = Response(body: itemList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(statusCode: 404, statusText: 'Item data not found');
    }
  }
}
