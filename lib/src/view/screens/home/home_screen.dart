import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/home_controller.dart';
import 'package:isp_management/src/view/screens/home/widget/item_view.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
   Get.find<HomeController>().getItemList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (home) => Scaffold(
        backgroundColor: MyColor.getBackgroundColor(),
        appBar: AppBar(
          title: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ISP Management'.tr, style: robotoLight.copyWith(fontSize: 22,
                color: MyColor.colorWhite,
              )),
            ],
          ),
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20,),
            onPressed: () => Get.back(canPop: true),
          ),
          elevation: 1,
          centerTitle: false,
          backgroundColor: MyColor.colorPrimary,
          shadowColor: MyColor.colorBlack.withOpacity(0.12),
          bottomOpacity: 0.3,
          automaticallyImplyLeading: false,
          titleSpacing: 10,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: MySizes.paddingSizeExtraSmall),


              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColor.colorPrimary,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  children: [
                    Stack( clipBehavior: Clip.none, alignment: Alignment.center,
                      children: [
                        const SizedBox(
                            height: 80,
                            width: 80,
                            child: CircularProgressIndicator(
                              value: 40/100,
                              strokeWidth: 8,
                              backgroundColor: MyColor.colorWhite,
                              valueColor:  AlwaysStoppedAnimation<Color>(Colors.yellow),
                            )),
                        Row(
                          children: [
                            SvgPicture.asset("assets/svg/auto_graph.svg", height: 24, width: 24,),
                            const SizedBox(width: 4,),
                            Text("96%", style: robotoBold.copyWith(color: MyColor.colorWhite, fontSize: 14),)
                          ],
                        )
                      ],
                    ),

                    const SizedBox(width: 16,),
                    Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Earning', style: robotoRegular.copyWith(color: MyColor.colorWhite),),
                        const SizedBox(height: 4,),
                        Text('278098', style: robotoExtraBold.copyWith(color: MyColor.colorWhite, fontSize: 22),),
                        const SizedBox(height: 4,),
                        Text('January 2023', style: robotoRegular.copyWith(color: MyColor.colorWhite),),
                      ],
                    ))
                  ],
                ),
              ),


              const SizedBox(height: MySizes.paddingSizeExtraSmall),
              StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: home.itemList.length,
                  itemBuilder: (context, index) => ItemView(itemModel: home.itemList[index], index: index,),
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1)),

            ],
          ),
        ),
      ),
    );
  }
}
