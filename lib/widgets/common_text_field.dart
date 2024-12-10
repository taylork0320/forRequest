import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasimee/styles/icons.dart';

import '../styles/color_styles.dart';

class TextFieldType {
  static final email = TextFieldType("email_hint".tr(), SvgIcons.email);
  static final password = TextFieldType("password_hint".tr(), SvgIcons.lock);
  static final passwordConfirmation =
      TextFieldType("password_confirmation_hint".tr(), SvgIcons.lock);
  static final name = TextFieldType("name_hint".tr(), SvgIcons.person);
  static final mobileNumber =
      TextFieldType("mobile_number_hint".tr(), SvgIcons.call);
  static final authenticationNumber = TextFieldType(
      "enter_authentication_number".tr().replaceAll('\n', ' '),
      SvgIcons.person);

  //TODO: 이름, 전화번호 등 회원 정보 입력 유형 추가 필요

  final String hintText;
  final SvgPicture prefixIcon;

  TextFieldType(this.hintText, this.prefixIcon);
}

class CommonTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextFieldType type;
  final FocusNode focusNode;
  final Widget? suffix;
  final String? error;
  final int? maxLength;

  const CommonTextField({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.focusNode,
    this.suffix,
    this.error,
    this.maxLength,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.type == TextFieldType.password ||
        widget.type == TextFieldType.passwordConfirmation;
    final isMobileNumberField = widget.type == TextFieldType.mobileNumber;
    final isAuthenticationNumberField =
        widget.type == TextFieldType.authenticationNumber;

    final phoneCode = isMobileNumberField
        ? CountryWithPhoneCode(
            phoneCode: '82',
            countryCode: 'KR',
            exampleNumberMobileNational: '010-1234-5678',
            exampleNumberFixedLineNational: '010-1234-5678',
            phoneMaskMobileNational: '000-0000-0000',
            phoneMaskFixedLineNational: '000-0000-0000',
            exampleNumberMobileInternational: '+82 10 1234 5678',
            exampleNumberFixedLineInternational: '+82 10 1234 5678',
            phoneMaskMobileInternational: '+00 00 0000 0000',
            phoneMaskFixedLineInternational: '+00 00 0000 0000',
            countryName: 'Republic of Korea')
        : null;

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
          maxLength: isMobileNumberField
              ? 13
              : (isAuthenticationNumberField ? 6 : widget.maxLength),
          inputFormatters: isMobileNumberField
              ? [
                  LibPhonenumberTextFormatter(
                    phoneNumberType: PhoneNumberType.fixedLine,
                    phoneNumberFormat: PhoneNumberFormat.national,
                    country: phoneCode!,
                    inputContainsCountryCode: true,
                    additionalDigits: 3,
                  ),
                ]
              : (isAuthenticationNumberField
                  ? [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ]
                  : null),
          style: isAuthenticationNumberField
              ? const TextStyle(
                  fontSize: 14,
                  letterSpacing: 6,
                )
              : null,
          keyboardType:
              isAuthenticationNumberField ? TextInputType.number : null,
          cursorColor: Colors.black54,
          obscureText: isPasswordField ? _obscureText : false,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: widget.focusNode.hasFocus
                ? ColorStyles.translucenceBlue
                : ColorStyles.textFieldBackground,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            prefixIcon: isAuthenticationNumberField
                ? null
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: widget.type.prefixIcon,
                  ),
            suffixIcon: isPasswordField
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
                : widget.suffix,
            hintText: widget.type.hintText,
            hintStyle: const TextStyle(
                color: ColorStyles.hintText,
                fontSize: 14,
                letterSpacing: 1,
                fontWeight: FontWeight.w400),
            focusColor: ColorStyles.translucenceBlue,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(width: 1, color: ColorStyles.primaryBlue),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            errorText: widget.error?.isNotEmpty == true ? widget.error : null,
            helperText: widget.error?.isEmpty == true ? '' : null,
          ),
        ),
      ),
    );
  }
}
