
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/package_controller.dart';
import 'package:isp_management/model/response/package_model.dart';
import 'package:isp_management/model/response/package_type_model.dart';
import 'package:isp_management/service/helper/sql_helper.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/custom_text_filed.dart';
import 'package:isp_management/src/view/base/custom_toast.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_style.dart';


class AddPackageScreen extends StatefulWidget {
  final bool isUpdate;
  final int index;
  final PackageModel? packageModel;
  const AddPackageScreen({super.key, this.isUpdate = false, this.index = 0, this.packageModel});
  @override
  State<AddPackageScreen> createState() => _AddPackageScreenState();
}

class _AddPackageScreenState extends State<AddPackageScreen> {

  final FocusNode _priceFocus = FocusNode();
  final TextEditingController _priceController = TextEditingController();
  late GlobalKey<FormState> _formKeyLogin;
 late GlobalKey<ScaffoldState> _globalKey;


  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<ScaffoldState>();
    _formKeyLogin = GlobalKey<FormState>();
    Get.find<PackageController>().initPackageTypeList(context);
    Get.find<PackageController>().initPackageNameList(context);

    if(widget.isUpdate && widget.packageModel != null){
      //_priceController.text = '${widget.packageModel.price}';
      if (widget.packageModel!.name == 'Economic') {
        Get.find<PackageController>().setPackageTypeIndex(0, false);
      } else if(widget.packageModel!.name == 'Basic') {
        Get.find<PackageController>().setPackageTypeIndex(1, false);
      }else if(widget.packageModel!.name == 'Family') {
        Get.find<PackageController>().setPackageTypeIndex(2, false);
      }else if(widget.packageModel!.name == 'Bachelor') {
        Get.find<PackageController>().setPackageTypeIndex(3, false);
      }else if(widget.packageModel!.name == 'Fast') {
        Get.find<PackageController>().setPackageTypeIndex(4, false);
      }else {
        Get.find<PackageController>().setPackageTypeIndex(5, false);
      }
      if(widget.packageModel!.packageName == '2Mbps'){
        Get.find<PackageController>().setPackageNameIndex(0, false);
      }else if(widget.packageModel!.packageName == '5Mbps') {
        Get.find<PackageController>().setPackageNameIndex(1, false);
      } else if(widget.packageModel!.packageName == '8Mbps') {
        Get.find<PackageController>().setPackageNameIndex(2, false);
      }else if(widget.packageModel!.packageName == '10Mbps') {
        Get.find<PackageController>().setPackageNameIndex(3, false);
      }else if(widget.packageModel!.packageName == '15Mbps') {
        Get.find<PackageController>().setPackageNameIndex(4, false);
      }else{
        Get.find<PackageController>().setPackageNameIndex(5, false);
      }
    }else{
      Get.find<PackageController>().setPackageTypeIndex(-1, false);
      Get.find<PackageController>().setPackageNameIndex(-1, false);
      _priceController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: CustomAppBar(title: 'ADD PACKAGE', onPressed: () => _globalKey.currentState?.openDrawer(),),
      drawer: Drawer(child: /*CustomDrawer()*/ Container()),
      body: Form(
        key: _formKeyLogin,
        child: SafeArea(
            child: GetBuilder<PackageController>(
                builder: (package) => ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [

                    // For Package Type
                    Text('Package Type', style: robotoBold.copyWith(fontSize: 16, color: MyColor.getTextColor())),
                    const SizedBox(height: 8),
                     package.packageTypeList.isNotEmpty ? Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: MyColor.colorGrey, width: 1),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: MyColor.getBackgroundColor(),
                        ),
                        child: DropdownButton<PackageTypeModel>(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: const Text('Select Package Type', style: robotoRegular),

                          icon: Icon(CupertinoIcons.chevron_forward, size: 20,
                              color: MyColor.getTextColor()),
                          value: package.packageIndex == -1 ? null : package.packageTypeList[package.packageIndex],
                          items: package.packageTypeList.map((PackageTypeModel clientData) {
                            return DropdownMenuItem<PackageTypeModel>(
                              value: clientData,
                              child: Text(clientData.leaveType ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor()), overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (PackageTypeModel? clientData) {
                            int index = package.packageTypeList.indexOf(clientData!);
                            package.setPackageTypeIndex(index, true);
                          },
                        ),
                      ),
                    ) : Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColor.getPrimaryColor()),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('No Package Yet!')) ,
                    const SizedBox(height: 5),



                    // For PackageName
                    Text('PackageName', style: robotoRegular.copyWith(fontSize: 16, color: MyColor.getTextColor())),
                    const SizedBox(height: 5),
                       package.packageNameList.isNotEmpty ? Container(
                         height: 40,
                         padding: const EdgeInsets.symmetric(horizontal: 18),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           border: Border.all(color: MyColor.colorGrey, width: 1),
                         ),
                         child: Theme(
                           data: Theme.of(context).copyWith(
                             canvasColor: MyColor.getBackgroundColor(),
                           ),
                           child: DropdownButton<PackageTypeModel>(
                             underline: const SizedBox(),
                             isExpanded: true,
                             hint:  Text('Select Package', style: robotoRegular.copyWith(color: MyColor.getTextColor()), overflow: TextOverflow.ellipsis),
                             icon: Icon(CupertinoIcons.chevron_forward, size: 20, color: MyColor.getHintColor()),
                             value: package.packageNameIndex == -1 ? null : package.packageNameList[package.packageNameIndex],
                             items: package.packageNameList.map((PackageTypeModel clientData) {
                               return DropdownMenuItem<PackageTypeModel>(
                                 value: clientData,
                                 child: Text(clientData.leaveType ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor()), overflow: TextOverflow.ellipsis),
                               );
                             }).toList(),
                             onChanged: (PackageTypeModel? clientData) {
                               int index = package.packageNameList.indexOf(clientData!);
                               package.setPackageNameIndex(index, true);
                             },
                           ),
                         ),
                       ) : Container(
                           alignment: Alignment.center,
                           margin: const EdgeInsets.symmetric(vertical: 16),
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             border: Border.all(color: MyColor.getPrimaryColor()),
                             borderRadius: BorderRadius.circular(10),
                           ),
                           child: const Text('No Package Yet!')) ,
                    const SizedBox(height: 5),

                    // For Remark
                    Text('Price', style: robotoRegular.copyWith(fontSize: 16, color: MyColor.getTextColor())),
                    const SizedBox(height: 5),
                    CustomTextField(
                      hintTxt: 'Price',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      focusNode: _priceFocus,
                      isEmail: false,
                      controller: _priceController,
                    ),
                    const SizedBox(height: 15),

                    // Button
                    !package.isLoading ?  Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          String remark = _priceController.text.trim();
                          if(Get.find<PackageController>().packageIndex == -1){
                            showSnackBar('Select Package Type');
                          } else if (Get.find<PackageController>().packageNameIndex == -1) {
                            showSnackBar('Select Package');
                          }else if (remark.isEmpty) {
                            showSnackBar('Enter Price');
                          } else {
                            PackageModel packageBody= PackageModel(
                              name: Get.find<PackageController>().packageTypeList[Get.find<PackageController>().packageIndex].leaveType ?? '',
                              packageName: Get.find<PackageController>().packageNameList[Get.find<PackageController>().packageNameIndex].leaveType ?? '',
                              price: int.parse(remark),
                            );


                            !widget.isUpdate ? DatabaseProvider.db.insert(packageBody).then((success) async {
                              Navigator.pop(context);
                              showSnackBar('Store Successfully');
                              package.addItem(packageBody);
                            }) : DatabaseProvider.db.update(widget.packageModel!).then((success) async {
                              Navigator.pop(context);
                              showSnackBar('Store Update Successfully');
                              package.updateItem(packageBody, widget.index);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: MyColor.getPrimaryColor(), width: 1),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text(widget.isUpdate ? 'Update' : 'Submit', style: robotoRegular.copyWith(color: MyColor.getPrimaryColor()),),
                        ),
                      ),
                    ) : const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColor.colorPrimary))),

                  ],
                )
            )
        ),
      ),
    );
  }
}




