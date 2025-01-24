import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/no_data_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<TransactionHistoryScreen> {

  @override
  void initState() {
    Get.find<CustomerController>().getTransactionHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (transaction) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: 'Transaction history'),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(alignment: Alignment.centerLeft,child: Text('Transaction history', style: robotoRegular.copyWith(fontSize: 16, color: MyColor.getTextColor()))),
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
              child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Txn ID/Date', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),),
                  Text('Description', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),),
                  Text('Amount', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),),
                ],
              ),
            ),
              transaction.transactionList.isNotEmpty ? Expanded(
                child: ListView.builder(
                    itemCount:  transaction.transactionList.length,
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 5),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  Container(
                        padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                        // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                        decoration: BoxDecoration(
                         // borderRadius: BorderRadius.circular(8),
                          color: index % 2 == 0 ? MyColor.getSurfaceColor() : MyColor.getHistoryColor(),
                          boxShadow: [BoxShadow(
                              color: MyColor.getGreyColor().withOpacity(0.2),
                              blurRadius: 0.1,
                              spreadRadius: 0.2,
                              offset: const Offset(0,1)
                          )],
                        ),
                        child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction.transactionList[index].name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),),
                                  Text(transaction.transactionList[index].date ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('#${transaction.transactionList[index].id}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),),
                                  Text(transaction.transactionList[index].photo ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),),
                                ],
                              ),
                            ),
                            Text('+${transaction.transactionList[index].amount ?? ''}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 12),),
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
