import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/no_data_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class SupportRequestScreen extends StatefulWidget {
  const SupportRequestScreen({super.key});

  @override
  State<SupportRequestScreen> createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<SupportRequestScreen> {



  @override
  void initState() {
    Get.find<CustomerController>().getSupportList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (transaction) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: 'Support request'),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(alignment: Alignment.centerLeft,child: Text('Support ticket history', style: robotoRegular.copyWith(fontSize: 16, color: MyColor.getTextColor()))),
              ),

              Container(
                padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                margin: const EdgeInsets.fromLTRB(12,8,12,0),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  color: MyColor.getSurfaceColor(),
                  border: const Border(bottom: BorderSide(color: Colors.grey)),
                  boxShadow: [BoxShadow(
                      color: MyColor.getGreyColor().withOpacity(0.2),
                      blurRadius: 0.1,
                      spreadRadius: 0.2,
                      offset: const Offset(0,1)
                  )],
                ),
                child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text('Date', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)),
                    const SizedBox(width: 60,),
                    Expanded(child: Text('Status', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)),
                   // const SizedBox(width: 20,),
                    Expanded(child: Text('Subject', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)),
                  ],
                ),
              ),
              transaction.supportList.isNotEmpty ? Expanded(
                child: ListView.builder(
                    itemCount:  transaction.supportList.length,
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 5),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  Container(
                        padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                        // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(8),
                          border: const Border(bottom: BorderSide(color: Colors.grey)),
                          color: index % 2 == 0 ? MyColor.getSurfaceColor() : MyColor.getHistoryColor(),
                          boxShadow: [BoxShadow(
                              color: MyColor.getGreyColor().withOpacity(0.2),
                              blurRadius: 0.1,
                              spreadRadius: 0.2,
                              offset: const Offset(0,1)
                          )],
                        ),
                        child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(child: Text(transaction.supportList[index].date ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),)),
                            const SizedBox(width: 10,),
                            Expanded(child: Container(
                              alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: transaction.supportList[index].isActive! ? MyColor.colorRed : const Color(0xFF8D8D93)
                                ),
                                child: Text('${transaction.supportList[index].name}', style: robotoRegular.copyWith(color: MyColor.getBackgroundColor(), fontSize: 12),))),
                            Expanded(child: Text('${transaction.supportList[index].id ?? ''}/ Fiber cut', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),)),
                          ],
                        ),
                      );
                    }),
              ) : const NoDataScreen(),

            ],
          ),
        ),

      ),
    );
  }
}
