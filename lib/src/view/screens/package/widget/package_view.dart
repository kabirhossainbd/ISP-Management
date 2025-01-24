import 'package:flutter/material.dart';
import 'package:isp_management/model/response/package_model.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class PackageView extends StatefulWidget {
  final PackageModel packageModel;
  final int index;
  const PackageView({super.key, required this.packageModel, this.index = 0});

  @override
  State<PackageView> createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {

  bool _animate = false;
  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
      setState(() {
        _animate = true;
        _isStart = false;
      });
    }) : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 1000),
        padding: _animate ? const EdgeInsets.all(4.0) : const EdgeInsets.only(top: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  alignment: Alignment.center,
                  // margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: MyColor.getPrimaryColor(),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                    boxShadow: [BoxShadow(
                        offset: const Offset(1,3),
                        color: MyColor.getSecondaryColor(),
                        spreadRadius: 0.5,
                        blurRadius: 0.5
                    )],
                  ),
                  child: Column(
                    children: [

                      Text(
                          widget.packageModel.name ?? '',
                          style: robotoBold.copyWith( color: MyColor.colorWhite,fontSize: MySizes.fontSizeLarge),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(
                          widget.packageModel.packageName ?? '',
                          style: robotoRegular.copyWith(
                              color: MyColor.colorWhite,
                              fontSize: MySizes.fontSizeExtraLarge), maxLines: 1, overflow: TextOverflow.ellipsis
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: MyColor.getSecondaryColor(),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                    boxShadow: [BoxShadow(
                        offset: const Offset(1,3),
                        color: MyColor.getSecondaryColor(),
                        spreadRadius: 0.5,
                        blurRadius: 0.5
                    )],
                  ),
                  child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          const Icon(Icons.wifi, size: 30, color: Colors.white,),
                          SizedBox(width: 5,),
                          Text(
                              'Unlimited Data',
                              style: robotoBold.copyWith( color: MyColor.colorWhite,fontSize: MySizes.fontSizeSmall),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),

                      Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '৳${widget.packageModel.price}',
                              style: robotoBold.copyWith(color: MyColor.colorWhite, fontSize: 24),
                              maxLines: 2, overflow: TextOverflow.ellipsis
                          ),
                          const SizedBox(width: 5,),
                          Text(
                              '/ Month',
                              style: robotoRegular.copyWith(color: MyColor.colorWhite, fontSize: 12),
                              maxLines: 2, overflow: TextOverflow.ellipsis
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Positioned(bottom: 5, right: 5,
            //   child:  Container(
            //     alignment: Alignment.center,
            //     padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            //     decoration: BoxDecoration(
            //       color: ColorResources.WHITE,
            //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topLeft: Radius.circular(12)),
            //       boxShadow: [BoxShadow(
            //           offset: Offset(1,3),
            //           color: ColorResources.getHintColor(context).withOpacity(0.4),
            //           spreadRadius: 0.5,
            //           blurRadius: 0.5
            //       )],
            //     ),
            //     child: Text('5% Discount',
            //         style: LatoBold.copyWith( color: ColorResources.COLOR_PRIMARY,fontSize: Dimensions.FONT_SIZE_SMALL),
            //         maxLines: 1, overflow: TextOverflow.ellipsis
            //     ),
            //   ),)
          ],
        ),
      ),
    );
  }
}
