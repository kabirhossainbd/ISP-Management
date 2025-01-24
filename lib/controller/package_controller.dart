import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/repo/package_repo.dart';
import 'package:isp_management/model/response/package_model.dart';
import 'package:isp_management/model/response/package_type_model.dart';
import 'package:isp_management/service/helper/sql_helper.dart';

class PackageController extends GetxController implements GetxService {
  final PackageRepo packageRepo;
  PackageController({required this.packageRepo});

  List<PackageModel> _packageList = [];
  List<PackageModel> get packageList => _packageList;

  bool _isEmpty = true;
  bool get isEmpty => _isEmpty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future refreshNote() async{
    _isEmpty = false;
    update();
    _packageList = [];
    _packageList = await DatabaseProvider.db.getPackageList();
    _isEmpty = true;
    update();
  }

  Future sort(bool ascending, bool price) async{
    _isLoading = true;
    update();
    _packageList = await DatabaseProvider.db.sortPackageList(ascending, price);
    _isLoading = false;
    update();
  }

  Future searchQuery(String query) async{
    _isLoading = true;
    update();
    _packageList = await DatabaseProvider.db.searchQuery(query);
    _isLoading = false;
    update();
  }

  addItem(PackageModel packageModel){
    _packageList.add(packageModel);
    update();
  }
  updateItem(PackageModel packageModel, int index){
    _packageList[index] = packageModel;
    update();
  }

  removeItem(int index){
    _packageList.removeAt(index);
    update();
  }
  final List<PackageTypeModel> _packageTypeList = [];
  List<PackageTypeModel> get packageTypeList => _packageTypeList;

  int _packageIndex = -1;
  int get packageIndex => _packageIndex;

  void initPackageTypeList(BuildContext context) async {
    Response response = await packageRepo.getPackageTypeList(context);
    if (response.statusCode == 200) {
      _packageTypeList.clear();
      _packageTypeList.addAll(response.body);
      update();
    } else {
      debugPrint(response.statusText);
    }
  }

  void setPackageTypeIndex(int index, bool notify) {
    _packageIndex = index;
    if (notify) {
      update();
    }
  }



  //PackageName
  final List<PackageTypeModel> _packageNameList = [];
  List<PackageTypeModel> get packageNameList => _packageNameList;

  int _packageNameIndex = -1;
  int get packageNameIndex => _packageNameIndex;

  void initPackageNameList(BuildContext context) async {
    Response response = await packageRepo.getPackageNameList(context);
    if (response.statusCode == 200) {
      _packageNameList.clear();
      _packageNameList.addAll(response.body);
      update();
    } else {
      debugPrint(response.statusText);
    }
  }

  void setPackageNameIndex(int index, bool notify) {
    _packageNameIndex = index;
    if (notify) {
      update();
    }
  }
}