import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isp_management/utils/my_color.dart';
import 'package:isp_management/utils/my_size.dart';
import 'package:isp_management/utils/my_style.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isEmail;
  final Function(String? text)? onSaved;
  final bool isAuth;
  final Color? fillColor;

  const CustomTextField(
      {super.key, this.controller,
        this.hintTxt,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.nextNode,
        this.textInputAction,
        this.isEmail = false,
        this.isPhoneNumber = false,
        this.onSaved,
        this.isAuth = true,
        this.fillColor});


  @override
  Widget build(context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: MySizes.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor.colorGrey, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        cursorColor: MyColor.colorPrimary,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        initialValue: null,
        onSaved: onSaved,
        style: robotoRegular.copyWith(color: MyColor.colorBlack),
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        inputFormatters: [
          isPhoneNumber?FilteringTextInputFormatter.digitsOnly:
          FilteringTextInputFormatter.singleLineFormatter],
        validator: (input) => isEmail?input!.isValidEmail() ? null : 'Please Provide a Valid Email' : null,
        decoration: InputDecoration(
          hintText: hintTxt ?? '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          isDense: true,
          hintStyle: robotoRegular.copyWith(color: MyColor.colorHint,fontSize: MySizes.fontSizeSmall),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}



class CustomPassField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;

  const CustomPassField({super.key,
    this.controller,
    this.hintTxt,
    this.focusNode,
    this.nextNode,
    this.textInputAction
  });


  @override
  State<CustomPassField> createState() => _CustomPassFieldState();
}

class _CustomPassFieldState extends State<CustomPassField> {

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: MySizes.marginSizeExtraLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColor.colorGrey, width: 1),
      ),
      child: TextFormField(
        cursorColor: MyColor.colorPrimary,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        style: robotoRegular.copyWith(color: MyColor.colorBlack),
        keyboardType: TextInputType.number,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          setState(() {
            widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nextNode);
          });
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: MyColor.colorHint),
            onPressed: _toggle,
          ),
          hintText: widget.hintTxt ?? '',
          contentPadding: const EdgeInsets.only(top: 15, left: 20),
          isDense: true,
          hintStyle: robotoBold.copyWith(color: MyColor.colorHint,fontSize: MySizes.fontSizeSmall),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

