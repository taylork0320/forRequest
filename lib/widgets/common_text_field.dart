import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sasimee/styles/icons.dart';
import '../styles/color_styles.dart';

class TextFieldType {
  static final email = TextFieldType("email_hint".tr(), SvgIcons.email);
  static final password = TextFieldType("password_hint".tr(), SvgIcons.lock);
  //TODO: 이름, 전화번호 등 회원 정보 입력 유형 추가 필요

  final String hintText;
  final SvgPicture prefixIcon;

  TextFieldType(this.hintText, this.prefixIcon);
}

class CommonTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextFieldType type;
  final FocusNode focusNode;

  const CommonTextField({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.focusNode,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Focus(
        focusNode: widget.focusNode,
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            widget.focusNode.unfocus();
          }
        },
        child: TextField(
          controller: widget.textEditingController,
          cursorColor: Colors.black54,
          obscureText: widget.type == TextFieldType.password ? _obscureText : false,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.focusNode.hasFocus
                ? ColorStyles.translucenceBlue
                : ColorStyles.textFieldBackground,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: widget.type.prefixIcon,
            ),
            suffixIcon: widget.type == TextFieldType.password
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            hintText: widget.type.hintText,
            hintStyle: const TextStyle(
                color: ColorStyles.hintText,
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
            focusColor: ColorStyles.translucenceBlue,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(width: 1, color: ColorStyles.primaryBlue),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
      ),
    );
  }
}