import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/repo/home_repo.dart';
import 'package:isp_management/model/response/home_model.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRequest homeRequest;
  HomeController({required this.homeRequest});


  List<ItemModel> _itemList = [];
  List<ItemModel> get itemList => _itemList;

  void getItemList() async{
    Response response  = await homeRequest.getItemList();
    if(response.statusCode == 200){
      _itemList = [];
      _itemList.addAll(response.body);
    }else{
      debugPrint(response.statusText);
    }
    update();
  }

}
