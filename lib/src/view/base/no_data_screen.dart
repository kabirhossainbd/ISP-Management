
import 'package:flutter/material.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:lottie/lottie.dart';
class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.paddingSizeLarge),
      child: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [

          Lottie.asset(
            MyImage.noData,
            width: MediaQuery.of(context).size.height*1, height: MediaQuery.of(context).size.height*.5,
          ),

          Text(
            'Nothing Found',
            style: robotoBold.copyWith(color: MyColor.getPrimaryColor(), fontSize: MediaQuery.of(context).size.height*0.023),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
