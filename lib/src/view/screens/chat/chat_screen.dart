import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:isp_management/controller/localization_controller.dart';
import 'package:isp_management/model/response/chat_model.dart';
import 'package:isp_management/src/view/base/custom_toast.dart';
import 'package:isp_management/src/view/screens/chat/custom_popup/custom_popup.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_image.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final List<ChatModel> _chatList = [];
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 400), (){
      if(scrollController.offset != scrollController.position.maxScrollExtent) {
        animateList();
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (local) => Scaffold(
        appBar: AppBar(
          title: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('chat'.tr, style: robotoLight.copyWith(fontSize: 22,
                color: MyColor.colorWhite,
              )),

              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: (){},
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(6,8,0,4),
                  padding: const EdgeInsets.fromLTRB(8,4,8,4),
                  decoration:  BoxDecoration(
                      boxShadow: [BoxShadow(
                          color: MyColor.getGreyColor().withOpacity(0.1),
                          blurRadius: 0.1,
                          spreadRadius: 0.2,
                          offset: const Offset(0,0)
                      )],
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          const Color(0xFF25D366),
                          const Color(0xFFA8845C).withOpacity(0.36),
                        ],)
                  ),
                  child: Row(
                    children: [
                      Text('10000', style: robotoRegular.copyWith(fontSize: MySizes.fontSizeDefault,
                        color: MyColor.colorWhite,
                      )),
                      const SizedBox(width: MySizes.paddingSizeExtraSmall,),
                      SvgPicture.asset(MyImage.star, width: 18,height: 19,),
                    ],
                  ),
                ),
              ),
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
          actions:  [
            CustomPopupMenuScreen(
              barrierColor: Colors.transparent,
              pressType: PressType.singleClick,
              arrowColor: Colors.white,
              verticalMargin: -5,
              showArrow: false,
              position: PreferredPosition.bottom,
              controller: Get.find<CustomPopupMenuController>(),
              menuBuilder: () => GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: MyColor.getBottomSheetColor(),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column( mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeExtraSmall ),
                          child: Row( mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(MyImage.trash, width: 24,height: 24,),
                              const SizedBox(width: MySizes.paddingSizeSmall),
                              Text('clear_history'.tr, style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor()),)
                            ],
                          ),
                        ),
                        const Divider(height: 4,color: MyColor.colorGrey,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeExtraSmall ),
                          child: Row( mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(MyImage.arrowShare, width: 24,height: 24,),
                              const SizedBox(width: MySizes.paddingSizeSmall),
                              Text('share'.tr, style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor()),)

                            ],
                          ),
                        ),
                      ],
                    )),
                onTap: () {
                  Get.find<CustomPopupMenuController>().hideMenu().then((value) {});},
              ),
              child: const Icon(Icons.more_vert_outlined, color: Colors.white,),
            ),
            const SizedBox(width: MySizes.fontSizeDefault,)
          ],
        ),
        backgroundColor: MyColor.getChatBoxColor(),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(MyImage.chatBg), fit: BoxFit.cover, opacity: 0.1)
          ),
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(bottom: 10),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _chatList.length,
                      itemBuilder: (context, index) {
                        return  _chatList.elementAt(index).isMee
                            ? _sender(_chatList.elementAt(index).message, local)
                            : _receiver(_chatList.elementAt(index).message, local);
                      }
                  )),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              _chatList.add(ChatModel('Regenerate response', true));
                              animateList();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal:MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeExtraSmall),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: MyColor.getGreyColor())
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(MyImage.refresh, width: 24,height: 24,),
                                const SizedBox(width: MySizes.paddingSizeSmall),
                                Text('regenerate_response'.tr, style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor().withOpacity(0.5)),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: MySizes.paddingSizeDefault),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal:MySizes.paddingSizeSmall, vertical: MySizes.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: MyColor.getGreyColor())
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(MyImage.image, width: 24,height: 24,),
                              const SizedBox(width: MySizes.paddingSizeSmall),
                              Text('screenshot'.tr, style: robotoRegular.copyWith(fontSize: MySizes.fontSizeSmall, color: MyColor.getTextColor().withOpacity(0.5)),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MySizes.paddingSizeDefault),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldBubble(
                              clipper: TextFieldClipper(alignment: local.isLtr ? Alignment.bottomLeft : Alignment.bottomRight),
                              backGroundColor: MyColor.getBottomSheetColor(),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLines: 4,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      controller: controller,
                                      onFieldSubmitted: (value) {
                                        controller.text = value;
                                      },
                                      onChanged: (v){
                                        setState(() {
                                          v = controller.text;
                                        });
                                      },
                                      style: robotoRegular.copyWith(color: MyColor.getTextColor()),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: local.isLtr ? 12 : 0, right: local.isLtr ? 0 : 12),
                                        border: InputBorder.none,
                                        focusColor: Colors.white,
                                        hintText: 'send_message'.tr,
                                        hintStyle: robotoRegular.copyWith(color: MyColor.getGreyColor()),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: MySizes.marginSizeDefault),
                                  Padding(
                                      padding:  EdgeInsets.only(bottom: 12, left: local.isLtr ? 0 : 16, right: local.isLtr ? 16 : 0),
                                      child: InkWell(onTap: (){},
                                          child: SvgPicture.asset(MyImage.mic, height: 24,width: 24,))
                                  ),

                                ],
                              )
                          ),
                        ),
                        const SizedBox(width: MySizes.paddingSizeMiniSmall,),
                        GestureDetector(
                          onTap: controller.text.isEmpty ? null : () {
                            if(controller.text.isNotEmpty){
                              setState(() {
                                _chatList.add(ChatModel(controller.text, true));
                                animateList();
                                controller.clear();
                              });
                            }else{
                              showSnackBar('write_something'.tr);
                            }

                          },
                          onLongPress: controller.text.isEmpty ? null : () {
                            if(controller.text.isNotEmpty){
                              setState(() {
                                _chatList.add(ChatModel(controller.text, false));
                                animateList();
                                controller.clear();
                              });
                            }else{
                              showSnackBar('write_something'.tr);
                            }

                          },
                          child: Image.asset(MyImage.send, height: 48,width: 48,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _sender(String text, LocalizationController local){
    return ChatBubble(
      clipper: ChatBubbleClipper2(alignment: local.isLtr ? Alignment.bottomLeft : Alignment.bottomRight),
      alignment: local.isLtr ? Alignment.topRight : Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20),
      padding:  EdgeInsets.fromLTRB(local.isLtr ? 10 : 22, 8, local.isLtr ? 22 : 10,8),
      backGroundColor: MyColor.getSenderBox(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          text,
          style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),
        ),

        // RichText(
        //   text: TextSpan(
        //     text: text,
        //     style: DefaultTextStyle.of(context).style.merge(robotoRegular.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor())),
        //     // children: <TextSpan>[
        //     //   TextSpan(text: ' ${DateFormat('H:mm a').format(DateTime.now())}',
        //     //     style: Theme.of(context).textTheme.bodySmall?.merge(
        //     //         robotoLight.copyWith(
        //     //             fontSize: MySizes.fontSizeDefault,
        //     //             color: MyColor.getGreyColor()
        //     //         )
        //     //     ),
        //     //   ),
        //     // ],
        //   ),
        // ),
      ),
    );
  }

  Widget _receiver(String text, LocalizationController local){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: MyColor.colorWhite,
          child: Image.asset(MyImage.bot, height: 15, width: 15, fit: BoxFit.cover,),
        ),
        ChatBubble(
          clipper: ChatBubbleClipper2(alignment: local.isLtr ? Alignment.bottomRight : Alignment.bottomLeft),
          backGroundColor: MyColor.getBottomSheetColor(),
          margin: const EdgeInsets.only(top: 20),
          padding:  EdgeInsets.fromLTRB(local.isLtr ? 22 : 10,8, local.isLtr ? 10 : 22,8),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: RichText(
              text: TextSpan(
                text: text,
                style: robotoLight.copyWith(fontSize: MySizes.fontSizeLarge, color: MyColor.getTextColor()),
                // children: <TextSpan>[
                //   TextSpan(text: ' ${DateFormat('H:mm a').format(DateTime.now())}',
                //     style: Theme.of(context).textTheme.bodySmall?.merge(
                //         robotoLight.copyWith(
                //             fontSize: MySizes.fontSizeDefault,
                //             color: MyColor.getGreyColor()
                //         )
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


/// for edit field
class TextFieldClipper extends CustomClipper<Path> {
  final Alignment? alignment;
  final double radius;
  final double nipHeight;
  final double nipWidth;
  final double nipRadius;

  TextFieldClipper(
      {this.alignment,
        this.radius = 10,
        this.nipHeight = 10,
        this.nipWidth = 10,
        this.nipRadius = 1});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (alignment == Alignment.bottomLeft) {
      path.lineTo(size.width - radius - nipWidth, 0);
      path.arcToPoint(Offset(size.width - nipWidth, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width - nipWidth, size.height - nipHeight);
      path.lineTo(size.width - nipRadius, size.height - nipRadius);
      path.arcToPoint(Offset(size.width - nipRadius, size.height),
          radius: Radius.circular(nipRadius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(nipRadius, size.height);
      path.arcToPoint(Offset(nipRadius, size.height - nipRadius),
          radius: Radius.circular(nipRadius));
      path.lineTo(nipWidth, size.height - nipHeight);
      path.lineTo(nipWidth, radius);
      path.arcToPoint(Offset(radius + nipWidth, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class TextFieldBubble extends StatelessWidget {
  final CustomClipper? clipper;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backGroundColor;
  final Color? shadowColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const TextFieldBubble(
      {super.key, this.clipper,
        this.child,
        this.margin,
        this.elevation,
        this.backGroundColor,
        this.shadowColor,
        this.alignment,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: PhysicalShape(
        clipper: clipper as CustomClipper<Path>,
        elevation: elevation ?? 2,
        color: backGroundColor ?? MyColor.colorPrimary,
        shadowColor: shadowColor ?? Colors.transparent,
        child: child ?? Container(),
      ),
    );
  }
}









/// for chat bubble
class ChatBubbleClipper2 extends CustomClipper<Path> {
  final Alignment? alignment;
  final double radius;
  final double nipHeight;
  final double nipWidth;
  final double nipRadius;

  ChatBubbleClipper2(
      {this.alignment,
        this.radius = 10,
        this.nipHeight = 10,
        this.nipWidth = 15,
        this.nipRadius =1});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (alignment == Alignment.bottomLeft) {
      path.lineTo(size.width - radius - nipWidth, 0);
      path.arcToPoint(Offset(size.width - nipWidth, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width - nipWidth, size.height - nipHeight);
      path.lineTo(size.width - nipRadius, size.height - nipRadius);
      path.arcToPoint(Offset(size.width - nipRadius, size.height),
          radius: Radius.circular(nipRadius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(nipRadius, size.height);
      path.arcToPoint(Offset(nipRadius, size.height - nipRadius),
          radius: Radius.circular(nipRadius));
      path.lineTo(nipWidth, size.height - nipHeight);
      path.lineTo(nipWidth, radius);
      path.arcToPoint(Offset(radius + nipWidth, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



class ChatBubble extends StatelessWidget {
  final CustomClipper? clipper;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backGroundColor;
  final Color? shadowColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;

  const ChatBubble(
      {super.key, this.clipper,
        this.child,
        this.margin,
        this.elevation,
        this.backGroundColor,
        this.shadowColor,
        this.alignment,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      margin: margin ?? const EdgeInsets.all(0),
      child: PhysicalShape(
        clipper: clipper as CustomClipper<Path>,
        elevation: elevation ?? 2,
        color: backGroundColor ?? MyColor.colorPrimary,
        shadowColor: shadowColor ?? Colors.transparent,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: child ?? Container(),
        ),
      ),
    );
  }
}



