import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/model/response/customer_model.dart';
import 'package:isp_management/service/helper/user_helper.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/no_data_screen.dart';
import 'package:isp_management/src/view/screens/customer/add_customer.dart';
import 'package:isp_management/src/view/screens/customer/widget/view.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:shimmer_animation/shimmer_animation.dart';



class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: 'New Customer',),
      body: SafeArea(
        child: GetBuilder<CustomerController>(
          builder: (attend) {
            return  attend.isEmpty ?  RefreshIndicator(
              onRefresh: () async {
                await Get.find<CustomerController>().refreshNote();
              },
              backgroundColor: MyColor.colorPrimary,
              color: MyColor.colorWhite,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 8, right: 8, top: 8 ),
                          decoration: BoxDecoration(
                            color: MyColor.getBackgroundColor(),
                            border: Border.all(color: MyColor.colorPrimary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.grey.shade500,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(bottom: 10),
                              hintStyle: robotoRegular.copyWith(color: MyColor.getGreyColor()),
                              hintText: 'Search Package...',
                              border: InputBorder.none,
                              prefixIcon: Icon(CupertinoIcons.search, color: MyColor.getTextColor(),),
                            ),
                            onChanged: (text){
                              attend.searchQuery(text);
                            },
                            style: robotoRegular.copyWith(color: MyColor.getTextColor()),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          child: const Icon(Icons.filter_alt_sharp, color: MyColor.colorBlack,),
                          itemBuilder: (_) => <PopupMenuItem<int>>[
                            PopupMenuItem<int>(
                                value: 0,
                                child: Text('A-Z by Name',style: robotoRegular.copyWith(color: MyColor.colorBlack),)),
                            PopupMenuItem<int>(
                                value: 1,
                                child: Text('Z-A by Name', style: robotoRegular.copyWith(color: MyColor.colorBlack))),
                          ],
                          onSelected: (int value)  {
                            attend.sort(value==0);
                          }),
                      const SizedBox(width: 10,)
                    ],
                  ),

                  attend.customerList.isNotEmpty ?  Expanded(
                    child: ListView.builder(
                        itemCount: attend.customerList.length,
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 10, bottom: 5),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () => _customLogout(context, attend.customerList[index], index),
                              child: CustomerView(customerModel: attend.customerList[index], index: index));
                        }),
                  )  : const NoDataScreen(),
                ],
              ),
            ) : AttendanceShimmer();
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddCustomerScreen(isUpdate: false)));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 15, right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1,1)
              )
            ],
            color: MyColor.colorWhite,
          ),
          child: Icon(Icons.add, color: MyColor.colorPrimary,),
        ),
      ),

    );
  }
}




class AttendanceShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: MySizes.paddingSizeSmall),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Shimmer(
          color: MyColor.getGreyColor(),
          duration: const Duration(seconds: 1),
          enabled:  true,
          child: Container(
            padding: const EdgeInsets.all(MySizes.paddingSizeDefault),
            margin: const EdgeInsets.all(MySizes.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5)
              ],
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 110,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 90,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

void _customLogout(BuildContext context, CustomerModel packageModel, int index) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
                alignment: Alignment.center,
                backgroundColor: MyColor.getBottomSheetColor(),
                insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () => Get.back(),
                              child: Text('cancel'.tr,
                                style: robotoRegular.copyWith(
                                    color: MyColor.colorGrey,
                                    fontSize:
                                    MySizes.fontSizeDefault),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )),
                          const SizedBox(width: 50),
                          // InkWell(
                          //     splashColor: Colors.transparent,
                          //     highlightColor: Colors.transparent,
                          //     hoverColor: Colors.transparent,
                          //     focusColor: Colors.transparent,
                          //     onTap: () => Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => AddCustomerScreen(packageModel: packageModel, isUpdate: true, index: index),
                          //       ),
                          //     ),
                          //     child: Container(
                          //       height: 40,
                          //       padding: const EdgeInsets.symmetric(horizontal: 20),
                          //       alignment: Alignment.center,
                          //       decoration: BoxDecoration(
                          //           color: const Color(0xFFF54336),
                          //           borderRadius: BorderRadius.circular(8)),
                          //       child: Text(
                          //         "Update".tr,
                          //         style: robotoRegular.copyWith(
                          //             color: MyColor.colorWhite,
                          //             fontSize:
                          //             MySizes.fontSizeDefault),
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 1,
                          //       ),
                          //     )
                          // ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () => DatabaseProvider.db.delete(packageModel.id ?? 0).then((_) {
                                Get.find<CustomerController>().removeItem(index);
                                Navigator.pop(context);
                              }),
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF54336),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Delete".tr,
                                  style: robotoRegular.copyWith(
                                      color: MyColor.colorWhite,
                                      fontSize:
                                      MySizes.fontSizeDefault),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              )
                          ),
                        ]),
                  ),
                  ],
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                title: Text('Employee Delete?'.tr, style: robotoLight.copyWith(
                    color: MyColor.getTextColor(),
                    fontSize: 28),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,),
                content:  Text( 'Are you sure want to Delete'.tr,
                  style: robotoLight.copyWith(
                      color: MyColor.getTextColor(),
                      fontSize:
                      MySizes.fontSizeLarge),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox();
      });
}
