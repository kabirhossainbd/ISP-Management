import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isp_management/model/response/active_customer_model.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class UserDetailsScreen extends StatefulWidget {
  final ActiveCustomerModel activeCustomerModel;
  final int index;
  const UserDetailsScreen({super.key, required this.activeCustomerModel, required this.index});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'User Details',),
      backgroundColor: MyColor.getBackgroundColor(),
      body: SafeArea(
        child: ListView(
          children: [
           Container(
             padding: const EdgeInsets.all(16),
             decoration: const BoxDecoration(
               color: Colors.white
             ),
             child: Column(
               children: [
                 Row(
                   children: [
                     Stack( alignment: Alignment.bottomRight,clipBehavior: Clip.none,
                       children: [
                         ClipOval(
                             child: Image.asset(widget.activeCustomerModel.photo ?? '', height: 76, width: 76, fit: BoxFit.cover,)),
                         Positioned(
                           bottom: -2, right: -2,
                           child: Container(
                             height: 24,
                             width: 24,
                             decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color:  widget.index % 2 == 0 ? MyColor.colorRed : MyColor.colorGreen,
                                 border: Border.all(color: Colors.white)
                             ),
                           ),
                         )
                       ],
                     ),
                     const SizedBox(width: 25,),
                     Column( crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(widget.activeCustomerModel.name ?? '', style: robotoRegular.copyWith(fontSize: 22, color: Colors.black)),
                         const SizedBox(height: 4,),
                         Text('ID # ${widget.activeCustomerModel.id}', style: robotoRegular.copyWith(fontSize: 16, color: Colors.black)),
                         const SizedBox(height: 4,),
                         RichText(text: TextSpan(
                             text: "Monthly ",
                             style: robotoRegular.copyWith(color: const Color(0xFF8D8D93), fontSize: 16),
                             children: [
                               TextSpan(
                                 text: "${widget.activeCustomerModel.amount} / 7Mbps.",
                                 style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: 16),
                               )
                             ]
                         )),
                       ],
                     )
                   ],
                 ),
                 const SizedBox(height: 20,),

                 _iconWithText(MyImage.dollar, 'Available balance ${widget.index % 2 == 0 ? 0.0 : widget.activeCustomerModel.amount}',onTap: (){}),
                 _iconWithText(MyImage.calendar, 'Valid Till: ${widget.activeCustomerModel.date}',onTap: (){}),
                 _iconWithText(MyImage.call, widget.activeCustomerModel.phone.toString(),onTap: (){}),
                 _iconWithText(MyImage.mail, widget.activeCustomerModel.email ?? '',onTap: (){}),
                 _iconWithText(MyImage.location, widget.activeCustomerModel.address ?? '',onTap: (){}),
               ],
             ),
           ),

            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Payment history', style: robotoRegular.copyWith(fontSize: 16, color: Colors.black)),
            ),

            const SizedBox(height: 8),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('Date', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            ),
                            const SizedBox(width: 2,),
                            Text('TK', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            Expanded(child: Text('Transaction Id', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text('01-Jan-23', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                            Text('500', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            Expanded(child: Text('X2yw4ywreGjhknX2yw4ywr', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('02-Feb-23', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            ),
                            Text('800', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            Expanded(child: Text('Z4yw4ywreGjhkn', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Support ticket history', style: robotoRegular.copyWith(fontSize: 16, color: Colors.black)),
            ),

            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('Date', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            ),
                            const SizedBox(width: 2,),
                            Text('Status', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            Expanded(child: Text('Subject', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text('05-Dec-22', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                              color: MyColor.colorRed,
                              borderRadius: BorderRadius.circular(100)
                            ),child: Text('Open', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: 12),)),
                            Expanded(child: Text('#454787 / Fiber cut', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
                    // margin: const EdgeInsets.fromLTRB(0,8,0,0),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.2),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,1)
                      )],
                    ),
                    child: Column(
                      children: [
                        Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text('10-May-23', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF8D8D93),
                                    borderRadius: BorderRadius.circular(100)
                                ),child: Text('Close', style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: 12),)),
                            Expanded(child: Text('#834787 / Fiber cut', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 12),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  _iconWithText(String image, String text, {VoidCallback? onTap}){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SvgPicture.asset(image, height: 24, width: 24,),
            const SizedBox(width: 8,),
            Text(text, style: robotoLight.copyWith(fontSize: 16, color: const Color(0xFF8D8D93)))
          ],
        ),
      ),
    );
  }
}
