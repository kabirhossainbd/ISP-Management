
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/model/response/home_model.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_helper.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class ItemView extends StatelessWidget {
  final ItemModel itemModel;
  final int index;
  const ItemView({Key? key, required this.itemModel, this.index = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Get.to(screenList[index]);
      },
      child: Container(
        height: 90,
        width: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(MySizes.paddingSizeSmall),
        margin: const EdgeInsets.fromLTRB(0,0,8,0),
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
        child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(itemModel.name ?? '', style: robotoExtraBold.copyWith(color: Color(0xFF6A6A6A), fontSize: MySizes.paddingSizeDefault), textAlign: TextAlign.center,),

            const SizedBox(height: 8,),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(right: 6),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF25D366),
                            Color(0xFF00A884),
                          ]),
                    ),
                    child: SvgPicture.asset(itemModel.image ?? '',color: MyColor.colorBackground, height: 16, width: 16,fit: BoxFit.scaleDown,)),
                Text(itemModel.amount ?? '', style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.paddingSizeDefault), textAlign: TextAlign.center,),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
