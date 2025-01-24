import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/custom_controller.dart';
import 'package:isp_management/src/view/screens/customer/customer_screen.dart';
import 'package:isp_management/src/view/screens/package/add_package.dart';
import 'package:isp_management/src/view/screens/package/package_list.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

   // Get.find<ProfileProvider>(context, listen: false).getUserInfo(context);
    return Scaffold(
      backgroundColor: Color(0xffF3F9FF),
      body: GetBuilder<CustomerController>(
          builder: (profile){
            return ListView(
              physics: ClampingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage(MyImage.profile))
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mr. John',
                              style: robotoRegular.copyWith(
                                  color: MyColor.getTextColor(), fontSize: 14)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('demo@gmail.com',
                              style: robotoRegular.copyWith(
                                  color: MyColor.getTextColor(), fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SwitchListTile(
                  value: true,
                  onChanged: (bool isActive) {},
                  title: Text('Dark', style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault)),
                  activeColor: MyColor.getPrimaryColor(),
                ),

                CustomDrawerWidget(
                    title: 'Customer List',
                    image: MyImage.profile,
                    widget: CustomerScreen()),
                menuDivider(context),
                CustomDrawerWidget(
                    title: 'Package List',
                    image: MyImage.profile,
                    widget: PackageList()),
                menuDivider(context),
                CustomDrawerWidget(
                    title: 'Add Package',
                    image: MyImage.profile,
                    widget: AddPackageScreen()),
                menuDivider(context),
                CustomDrawerWidget(
                  title: 'LogOut',
                  image: MyImage.profile,
                  widget: Container(),
                  isLogout: true,
                ),
                menuDivider(context),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }
      ),
    );
  }
}

class CustomDrawerWidget extends StatelessWidget {
  final String title;
  final String image;
  final Widget widget;
  final bool isLogout;

  CustomDrawerWidget(
      {required this.title,
        required this.image,
        required this.widget,
        this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => isLogout
            ? showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => widget)
            : Navigator.push(
            context, MaterialPageRoute(builder: (_) => widget)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text(title,
            style: robotoRegular.copyWith(
                color: MyColor.getTextColor(), fontSize: 14)),
        // leading: Image.asset(
        //   image,
        //   height: 25,
        //   width: 25,
        //   color: MyColor.getPrimaryColor(),
        // )
    );
  }


}

Widget menuDivider(BuildContext context) {
  return Container(
    height: 4,
    width: double.infinity,
    decoration: BoxDecoration(
      color: MyColor.getTextColor(),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF1F1F1),
            Color(0xff9E9E9E),
          ]),
    ),
  );
}
