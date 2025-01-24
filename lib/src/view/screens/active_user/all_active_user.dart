import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/screens/active_user/user_details_screen.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class AllActiveUserScreen extends StatefulWidget {
  const AllActiveUserScreen({super.key});

  @override
  State<AllActiveUserScreen> createState() => _ActiveUserScreenState();
}

class _ActiveUserScreenState extends State<AllActiveUserScreen> {
  final TextEditingController _nameSearch = TextEditingController();

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
        appBar: const CustomAppBar(title: 'All customer list'),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                height: 40,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8 ),
                decoration: BoxDecoration(
                  color: MyColor.getBackgroundColor(),
                  border: Border.all(color: MyColor.colorPrimary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _nameSearch,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.grey.shade500,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    hintStyle: robotoRegular.copyWith(color: Colors.grey.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: MySizes.fontSizeLarge),
                    hintText: 'Search active user Name',
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.search, color: MyColor.getTextColor(),),
                  ),
                  onChanged: active.onActiveAllUserSearch,
                  style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: Text('All customer list', style: robotoRegular.copyWith(fontSize: 16, color: MyColor.getTextColor()))),
                    PopupMenuButton(
                      color: MyColor.getCardColor(),
                        child: Icon(Icons.filter_alt_sharp, color: MyColor.getTextColor(),),
                        itemBuilder: (_) => <PopupMenuItem<int>>[
                          PopupMenuItem<int>(
                              value: -1,
                              child: Text('All user', style: robotoRegular.copyWith(color: MyColor.colorPrimary),)),
                          PopupMenuItem<int>(
                              value: 0,
                              child: Text('Active user', style: robotoRegular.copyWith(color: MyColor.colorPrimary),)),
                          PopupMenuItem<int>(
                              value: 1,
                              child: Text('Inactive user',style: robotoRegular.copyWith(color: MyColor.colorPrimary),)),
                         ],
                        onSelected: (int value)  {
                        active.onSortUser(value);
                        _nameSearch.clear();
                        }),
                  ],
                ),
              ),

              if(_nameSearch.text.isNotEmpty)...[
                Expanded(
                  child: ListView.builder(
                      itemCount: active.searchActiveAllCustomer.length,
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 5),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => UserDetailsScreen(activeCustomerModel: active.searchActiveAllCustomer[index], index: index,))),
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
                                        child: Image.asset(active.searchActiveAllCustomer[index].photo ?? '', height: 42, width: 42, fit: BoxFit.cover,)),
                                    if(active.searchActiveAllCustomer[index].isActive!)...[
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
                                    ]
                                  ],
                                ),
                                const SizedBox(width: 12,),
                                Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(active.searchActiveAllCustomer[index].name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14)),
                                    const SizedBox(height: 2,),
                                    Text('User ID:${active.searchActiveAllCustomer[index].id ?? ''}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)
                                  ],
                                )),

                                Icon(Icons.arrow_forward_ios_sharp, size: 20, color: MyColor.getTextColor(),)
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ]else if(active.sortActiveAllCustomer.isNotEmpty)...[
                Expanded(
                  child: ListView.builder(
                      itemCount: active.sortActiveAllCustomer.length,
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 5),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (_) => UserDetailsScreen(activeCustomerModel: active.sortActiveAllCustomer[index], index: index,))),
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
                                        child: Image.asset(active.sortActiveAllCustomer[index].photo ?? '', height: 42, width: 42, fit: BoxFit.cover,)),
                                    if(active.sortActiveAllCustomer[index].isActive!)...[
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
                                    ]
                                  ],
                                ),
                                const SizedBox(width: 12,),
                                Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(active.sortActiveAllCustomer[index].name ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14)),
                                    const SizedBox(height: 2,),
                                    Text('User ID:${active.sortActiveAllCustomer[index].id ?? ''}', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 14),)
                                  ],
                                )),

                                Icon(Icons.arrow_forward_ios_sharp, size: 20, color: MyColor.getTextColor(),)
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ]else...[
                Expanded(
                  child: ListView.builder(
                      itemCount: active.allActiveCustomer.length,
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
                                    ]
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
              ]
            ],
          ),
        ),
      ),
    );
  }
}
