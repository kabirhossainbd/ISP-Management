import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/repo/customer_repo.dart';
import 'package:isp_management/model/response/active_customer_model.dart';
import 'package:isp_management/model/response/customer_model.dart';
import 'package:isp_management/service/helper/user_helper.dart';

class CustomerController extends GetxController implements GetxService {
  final CustomerRepo customerRepo;
  CustomerController({required this.customerRepo});


  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CustomerModel> _customerList = [];
  List<CustomerModel> get customerList => _customerList;

  Future refreshNote() async{
    _isLoading = true;
    _isEmpty = false;
    update();
    _customerList = await DatabaseProvider.db.getCustomerList();
    _isLoading = false;
    update();
  }


  Future sort(bool ascending,) async{
    _isLoading = true;
   // _isEmpty = true;
    update();
    _customerList = await DatabaseProvider.db.sortPackageList(ascending);
    _isLoading = false;
   // _isEmpty = false;
    update();
  }

  Future searchQuery(String query) async{
    _isLoading = true;
   // _isEmpty = true;
    update();
    _customerList = await DatabaseProvider.db.searchQuery(query);
    _isLoading = false;
   // _isEmpty = false;
    update();
  }

  addItem(CustomerModel customerModel){
    _customerList.add(customerModel);
    update();
  }
  updateItem(CustomerModel customerModel, int index){
    _customerList[index] = customerModel;
    update();
  }

  removeItem(int index){
    _customerList.removeAt(index);
    update();
  }


  List<ActiveCustomerModel> _activeCustomer = [];
  List<ActiveCustomerModel> get activeCustomer => _activeCustomer;

  List<ActiveCustomerModel> _searchActiveCustomer = [];
  List<ActiveCustomerModel> get searchActiveCustomer => _searchActiveCustomer;

  Future<void> getActiveCustomer() async{
    Response response = await customerRepo.getActiveCustomer();
    if(response.statusCode == 200){
      _activeCustomer =[];
      _activeCustomer.addAll(response.body);
      _searchActiveCustomer = [];
      _searchActiveCustomer.addAll(response.body);
      update();
    }else{
      debugPrint("Nothing to found");
    }
  }

  onActiveUserSearch(String text) async {
    _searchActiveCustomer.clear();
    if (text.isEmpty) {
      _searchActiveCustomer.clear();
      update();
    }
    for (var userDetail in _activeCustomer) {
      if (userDetail.name!.toUpperCase().capitalizeFirst!.startsWith(text)  || userDetail.name!.toLowerCase().startsWith(text)) {
        _searchActiveCustomer.add(userDetail);
      }
    }


    update();
  }




  /// for all active user

  List<ActiveCustomerModel> _allActiveCustomer = [];
  List<ActiveCustomerModel> get allActiveCustomer => _allActiveCustomer;

  List<ActiveCustomerModel> _searchActiveAllCustomer = [];
  List<ActiveCustomerModel> get searchActiveAllCustomer => _searchActiveAllCustomer;


  List<ActiveCustomerModel> _sortActiveAllCustomer = [];
  List<ActiveCustomerModel> get sortActiveAllCustomer => _sortActiveAllCustomer;

  Future<Response> getAllActiveCustomer() async{
    Response response = await customerRepo.getAllActiveCustomer();
    if(response.statusCode == 200){
      _allActiveCustomer =[];
      _allActiveCustomer.addAll(response.body);
      _searchActiveAllCustomer =[];
      _searchActiveAllCustomer.addAll(response.body);
      _sortActiveAllCustomer =[];
      _sortActiveAllCustomer.addAll(response.body);
    }else{
      debugPrint("Nothing to found");
    }
    update();
    return response;
  }

  onActiveAllUserSearch(String text) async {
    _searchActiveAllCustomer.clear();
    if (text.isEmpty) {
      _searchActiveAllCustomer.clear();
      update();
    }
    for (var userDetail in _allActiveCustomer) {
      if (userDetail.name!.toUpperCase().capitalizeFirst!.startsWith(text)  || userDetail.name!.toLowerCase().startsWith(text)) {
        _searchActiveAllCustomer.add(userDetail);
      }
    }
    update();
  }

  onSortUser(int value) async {
    _sortActiveAllCustomer.clear();
    if (value == -1) {
      _searchActiveAllCustomer.clear();
      update();
    }
    for (var userDetail in _allActiveCustomer) {
      if(value == 0){
        if (userDetail.isActive!) {
          _sortActiveAllCustomer.add(userDetail);
        }
      }else if(value == 1){
        if (!userDetail.isActive!) {
          _sortActiveAllCustomer.add(userDetail);
        }
      }
    }


    update();
  }


  /// for transaction

  List<ActiveCustomerModel> _transactionList = [];
  List<ActiveCustomerModel> get transactionList => _transactionList;

  Future<Response> getTransactionHistory() async{
    Response response = await customerRepo.getTransactionHistory();
    if(response.statusCode == 200){
      _transactionList =[];
      _transactionList.addAll(response.body);
    }else{
      debugPrint("Nothing to found");
    }
    update();
    return response;
  }


  /// for support

  List<ActiveCustomerModel> _supportList = [];
  List<ActiveCustomerModel> get supportList => _supportList;

  Future<Response> getSupportList() async{
    Response response = await customerRepo.getSupportList();
    if(response.statusCode == 200){
      _supportList =[];
      _supportList.addAll(response.body);
    }else{
      debugPrint("Nothing to found");
    }
    update();
    return response;
  }

}