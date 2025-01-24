import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/package_controller.dart';
import 'package:isp_management/model/response/package_model.dart';
import 'package:isp_management/service/helper/sql_helper.dart';
import 'package:isp_management/src/view/base/custom_appbar.dart';
import 'package:isp_management/src/view/base/no_data_screen.dart';
import 'package:isp_management/src/view/screens/package/add_package.dart';
import 'package:isp_management/src/view/screens/package/widget/package_view.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PackageList extends StatefulWidget {
  const PackageList({super.key});

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {

  @override
  void initState() {
    super.initState();
     Get.find<PackageController>().refreshNote();
  }


  @override
  void dispose() {
    super.dispose();
    DatabaseProvider.db.close();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      builder: (package) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: const CustomAppBar(title: 'Package List'),
        body: SafeArea(
          child: GetBuilder<PackageController>(
            builder: (leave) {
              return  package.isEmpty ? RefreshIndicator(
                onRefresh: () async {
                  await DatabaseProvider.db.getPackageList();
                },
                backgroundColor: MyColor.getPrimaryColor(),
                color: MyColor.colorWhite,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 8 ),
                            decoration: BoxDecoration(
                              color: MyColor.getBackgroundColor(),
                              border: Border.all(color: MyColor.colorPrimary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.grey.shade500,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 10),
                                hintStyle: robotoRegular.copyWith(color: Colors.grey.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: MySizes.fontSizeLarge),
                                hintText: 'Search Package...',
                                border: InputBorder.none,
                                prefixIcon: Icon(CupertinoIcons.search, color: MyColor.getTextColor(),),
                              ),
                              onChanged: (text){
                                package.searchQuery(text);
                              },
                              style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        PopupMenuButton(
                            child:  Icon(Icons.filter_alt_sharp, color: MyColor.getTextColor(),),
                            itemBuilder: (_) => <PopupMenuItem<int>>[
                              PopupMenuItem<int>(
                                  value: 0,
                                  child: Text('A-Z by Name', style: robotoRegular.copyWith(color: MyColor.colorBlack),)),
                              PopupMenuItem<int>(
                                  value: 1,
                                  child: Text('Z-A by Name',style: robotoRegular.copyWith(color: MyColor.colorBlack),)),
                              PopupMenuItem<int>(
                                  value: 2,
                                  child: Text('Price High-Low',style: robotoRegular.copyWith(color: MyColor.colorBlack),)),
                              PopupMenuItem<int>(
                                  value: 3,
                                  child: Text('Price Low-High',style: robotoRegular.copyWith(color: MyColor.colorBlack),)),
                            ],
                            onSelected: (int value)  {
                              package.sort(value==0 || value ==3, value==2 || value==3);
                            }),
                        const SizedBox(width: 16,)
                      ],
                    ),
                    package.packageList.isNotEmpty ? Expanded(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1/1,
                              crossAxisCount: 2
                          ),
                          itemCount: package.packageList.length,
                          padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 5),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () => showFoodDialog(context, package.packageList[index], index),
                                child: PackageView(packageModel: package.packageList[index], index: index,));
                          }),
                    ) : const NoDataScreen(),
                  ],
                ),
              ) : const LeaveShimmer();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPackageScreen(isUpdate: false)));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 15, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1,1)
                )
              ],
              color: MyColor.colorWhite,
            ),
            child: Icon(Icons.add, color: MyColor.colorPrimary,),
          ),
        ),

      ),
    );
  }
}


class LeaveShimmer extends StatelessWidget {
  const LeaveShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: MySizes.paddingSizeSmall),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Shimmer(
          color: MyColor.getGreyColor(),
          duration: const Duration(seconds: 1),
          enabled: true,
          child: Container(
            padding: const EdgeInsets.all(MySizes.paddingSizeDefault),
            margin: const EdgeInsets.all(MySizes.paddingSizeSmall),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5)
              ],
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 110,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: MyColor.getGreyColor(),
                      height: 10,
                      width: 90,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

showFoodDialog(BuildContext context, PackageModel packageModel, int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(packageModel.name ?? ''),
      content: Text("ID ${packageModel.id}"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddPackageScreen(packageModel: packageModel, isUpdate: true, index: index),
            //   ),
            // ),
          },

          child: const Text("Update"),
        ),
        TextButton(
          onPressed: () =>
              DatabaseProvider.db.delete(packageModel.id ?? 0).then((_) {
            Get.find<PackageController>().removeItem(index);
            Navigator.pop(context);
          }),
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    ),
  );
}
