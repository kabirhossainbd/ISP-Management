import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/screens/active_user/user_details_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  @override
  void initState() {
    Get.find<CustomerController>().getAllActiveCustomer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (active) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: 'Employee list'),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 5),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => UserDetailsScreen(activeCustomerModel: active.allActiveCustomer[index], index: index,))),
                        child: Container(
                          padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                          margin: const EdgeInsets.fromLTRB(0,8,0,0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: MyColor.getSurfaceColor(),
                            boxShadow: [BoxShadow(
                                color: MyColor.getGreyColor().withOpacity(0.2),
                                blurRadius: 0.1,
                                spreadRadius: 0.2,
                                offset: const Offset(0,1)
                            )],
                          ),
                          child: Row(
                            children: [
                              Stack( alignment: Alignment.bottomRight,clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(active.allActiveCustomer[index].photo ?? '', height: 42, width: 42, fit: BoxFit.cover,)),
                                  if(active.allActiveCustomer[index].isActive!)...[
                                    Positioned(
                                      bottom: -2, right: -2,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColor.colorPrimary
                                        ),
                                      ),
                                    )
                                  ]else...[
                                    Positioned(
                                      bottom: -2, right: -2,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: MyColor.colorYellow
                                        ),
                                      ),
                                    )
                                  ],
                                ],
                              ),
                              const SizedBox(width: 12,),
                              Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(active.allActiveCustomer[index].name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14)),
                                  const SizedBox(height: 2,),
                                  Text('User ID:${active.allActiveCustomer[index].id ?? ''}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)
                                ],
                              )),

                              Icon(Icons.arrow_forward_ios_sharp, size: 20, color: MyColor.getTextColor(),)
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
