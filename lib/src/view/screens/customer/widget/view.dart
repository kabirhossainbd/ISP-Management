import 'package:flutter_svg/flutter_svg.dart';
import 'package:isp_management/model/response/customer_model.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:flutter/material.dart';

class CustomerView extends StatefulWidget {
  final CustomerModel customerModel;
  final int index;
  const CustomerView({super.key, required this.customerModel, this.index = 0});

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
      setState(() {
        _animate = true;
        _isStart = false;
      });
    })
        : _animate = true;
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
            child:
            Row(
              children: [
                Container(
                  height: 42, width: 42,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColor.getPrimaryColor(),
                    boxShadow: [BoxShadow(
                        color: MyColor.getGreyColor().withOpacity(0.2),
                        blurRadius: 0.1,
                        spreadRadius: 0.2,
                        offset: const Offset(0,1)
                    )],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SvgPicture.asset(MyImage.user, height: 42, width: 42, fit: BoxFit.cover,)),
                ),
                const SizedBox(width: 12,),
                Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.customerModel.name ?? '', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 14)),
                    const SizedBox(height: 2,),
                    Text('Employee ID: 100${widget.customerModel.id}', style: robotoRegular.copyWith(color: MyColor.colorBlack, fontSize: 14),)
                  ],
                )),

                const Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.black,)
              ],
            ),

           /* Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Image.asset(MyImage.profile, height: 30, width: 30, fit: BoxFit.cover,),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.customerModel.name ?? '',
                          style: robotoRegular.copyWith( color: MyColor.colorWhite,fontSize: MySizes.fontSizeLarge),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      Text(widget.customerModel.type ?? '',
                          style: robotoRegular.copyWith( color: MyColor.colorWhite,fontSize: MySizes.fontSizeLarge),
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      Text(
                          widget.customerModel.email ?? '',
                          style: robotoRegular.copyWith(
                              color: MyColor.colorWhite,
                              fontSize: MySizes.fontSizeSmall), maxLines: 2, overflow: TextOverflow.ellipsis
                      ),
                      Text(
                          widget.customerModel.phone ?? '',
                          style: robotoRegular.copyWith(
                              color: MyColor.colorWhite,
                              fontSize: MySizes.fontSizeSmall), maxLines: 2, overflow: TextOverflow.ellipsis
                      ),
                      Text(
                          widget.customerModel.address ?? '',
                          style: robotoRegular.copyWith(
                              color: MyColor.colorWhite,
                              fontSize: MySizes.fontSizeSmall), maxLines: 2, overflow: TextOverflow.ellipsis
                      ),

                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await canLaunch(_contactNumber)
                        ? await launch(_contactNumber)
                        : throw 'Could not launch $_contactNumber';
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.call_end),
                  ),
                )
              ],
            ),*/
          )
      ),
    );
  }
}
