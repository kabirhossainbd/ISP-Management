
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/controller/package_controller.dart';
import 'package:isp_management/model/response/customer_model.dart';
import 'package:isp_management/model/response/package_type_model.dart';
import 'package:isp_management/service/helper/user_helper.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/custom_text_filed.dart';
import 'package:isp_management/src/view/base/custom_toast.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';


class AddCustomerScreen extends StatefulWidget {
  final bool isUpdate;
  final int index;
  final CustomerModel? packageModel;
  AddCustomerScreen({this.isUpdate = false, this.index = 0, this.packageModel});
  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {

  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _addressFocus = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
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
      if (widget.packageModel?.type == 'Economic') {
        Get.find<PackageController>().setPackageTypeIndex(0, false);
      } else if(widget.packageModel?.type == 'Basic') {
        Get.find<PackageController>().setPackageTypeIndex(1, false);
      }else if(widget.packageModel?.type == 'Family') {
        Get.find<PackageController>().setPackageTypeIndex(2, false);
      }else if(widget.packageModel?.type == 'Bachelor') {
        Get.find<PackageController>().setPackageTypeIndex(3, false);
      }else if(widget.packageModel?.type == 'Fast') {
        Get.find<PackageController>().setPackageTypeIndex(4, false);
      }else {
        Get.find<PackageController>().setPackageTypeIndex(5, false);
      }
    }else{
      Get.find<PackageController>().setPackageTypeIndex(-1, false);
      Get.find<PackageController>().setPackageNameIndex(-1, false);
      _nameController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: 'Add Customer'),
     /* drawer: Drawer(child: CustomDrawer()),*/
      body: Form(
        key: _formKeyLogin,
        child: SafeArea(
            child: GetBuilder<PackageController>(
              builder: (pack) => GetBuilder<CustomerController>(
                  builder: (package) => ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeSmall),
                    children: [


                      // For Remark
                      Text('Name', style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault, color: MyColor.getTextColor())),
                      const SizedBox(height: MySizes.paddingSizeSmall),
                      CustomTextField(
                        hintTxt: 'Name',
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        focusNode: _nameFocus,
                        nextNode: _emailFocus,
                        isEmail: false,
                        controller: _nameController,
                      ),
                      const SizedBox(height: MySizes.paddingSizeSmall),


                      // For Package Type
                      Text('Package Type', style: robotoRegular.copyWith(fontSize: MySizes.paddingSizeSmall, color: MyColor.getTextColor())),
                      const SizedBox(height: MySizes.paddingSizeSmall),
                      pack.packageTypeList.isNotEmpty ? Container(
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
                            icon: Icon(CupertinoIcons.chevron_forward, size: 20, color: MyColor.getHintColor()),
                            value: pack.packageIndex == -1 ? null : pack.packageTypeList[pack.packageIndex],
                            items: pack.packageTypeList.map((PackageTypeModel clientData) {
                              return DropdownMenuItem<PackageTypeModel>(
                                value: clientData,
                                child: Text(clientData.leaveType ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor()), overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (PackageTypeModel? clientData) {
                              int index = pack.packageTypeList.indexOf(clientData!);
                              pack.setPackageTypeIndex(index, true);
                            },
                          ),
                        ),
                      )
                          : Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: MySizes.paddingSizeSmall),
                          padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor.getPrimaryColor()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('No Client Yet!')),
                      const SizedBox(height: MySizes.paddingSizeSmall),



                      // For Remark
                      Text('Email', style: robotoRegular.copyWith(fontSize: MySizes.paddingSizeSmall, color: MyColor.getTextColor())),
                      const SizedBox(height: MySizes.paddingSizeSmall),
                      CustomTextField(
                        hintTxt: 'Email',
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocus,
                        nextNode: _phoneFocus,
                        isEmail: true,
                        controller: _emailController,
                      ),
                      const SizedBox(height: MySizes.paddingSizeSmall),

                      // For Remark
                      Text('Phone', style: robotoRegular.copyWith(fontSize: MySizes.paddingSizeSmall, color: MyColor.getTextColor())),
                      const SizedBox(height: MySizes.paddingSizeSmall),
                      CustomTextField(
                        hintTxt: 'Phone',
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _phoneFocus,
                        nextNode: _addressFocus,
                        isEmail: false,
                        controller: _phoneController,
                      ),
                      const SizedBox(height: MySizes.paddingSizeSmall),

                      // For Remark
                      Text('Address', style: robotoRegular.copyWith(fontSize: MySizes.paddingSizeSmall, color: MyColor.getTextColor())),
                      const SizedBox(height: MySizes.paddingSizeSmall),
                      CustomTextField(
                        hintTxt: 'address',
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: _addressFocus,
                        isEmail: false,
                        controller: _addressController,
                      ),
                      const SizedBox(height: MySizes.paddingSizeSmall),

                      // Button
                      !package.isLoading ?  Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            String _name = _nameController.text.trim();
                            String _email = _emailController.text.trim();
                            String _phone = _phoneController.text.trim();
                            String _address = _addressController.text.trim();
                            if(Get.find<PackageController>().packageIndex == -1){
                              showSnackBar('Select Package Type');
                            }else if (_name.isEmpty) {
                              showSnackBar('Enter Name');
                            } else {
                              CustomerModel packageBody= CustomerModel(
                                name: _name,
                                type: Get.find<PackageController>().packageTypeList[Get.find<PackageController>().packageIndex].leaveType,
                                email: _email,
                                phone: _phone,
                                address: _address,
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
                      ) : Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(MyColor.colorPrimary))),

                    ],
                  )
              ),
            )
        ),
      ),
    );
  }
}




