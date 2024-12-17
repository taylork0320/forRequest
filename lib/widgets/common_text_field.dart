import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sasimee/styles/icons.dart';

import '../styles/color_styles.dart';

class TextFieldType {
  static final basic = TextFieldType("", null);
  static final email = TextFieldType("email_hint".tr(), SvgIcons.email);
  static final password = TextFieldType("password_hint".tr(), SvgIcons.lock);
  static final passwordConfirmation =
      TextFieldType("password_confirmation_hint".tr(), SvgIcons.lock);
  static final name = TextFieldType("name_hint".tr(), SvgIcons.person);
  static final mobileNumber =
      TextFieldType("mobile_number_hint".tr(), SvgIcons.call);
  static final authenticationCode = TextFieldType(
      "enter_authentication_code".tr().replaceAll('\n', ' '), null);

  static final profileEmail = TextFieldType("email_hint".tr(), null);
  static final profileName = TextFieldType("name_hint".tr(), null);
  static final profileMobileNumber =
      TextFieldType("mobile_number_hint".tr(), null);

  final String hintText;
  final SvgPicture? prefixIcon;

  TextFieldType(this.hintText, this.prefixIcon);
}

class CommonTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextFieldType type;
  final FocusNode focusNode;
  final bool showPrefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? error;
  final int? maxLength;

  const CommonTextField({
    super.key,
    required this.textEditingController,
    required this.type,
    required this.focusNode,
    this.showPrefix = true,
    this.suffix,
    this.suffixIcon,
    this.error,
    this.maxLength,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = true;
  bool _readOnly = true;

  late final _isPasswordField = widget.type == TextFieldType.password ||
      widget.type == TextFieldType.passwordConfirmation;
  late final _isMobileNumberField = widget.type == TextFieldType.mobileNumber ||
      widget.type == TextFieldType.profileMobileNumber;
  late final _isAuthenticationCodeField =
      widget.type == TextFieldType.authenticationCode;
  late final _isProfile = [
    TextFieldType.profileMobileNumber,
    TextFieldType.profileEmail,
    TextFieldType.profileName,
  ].contains(widget.type);

  late final _phoneCode = _isMobileNumberField
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

  @override
  void initState() {
    _readOnly = _isProfile;

    super.initState();
  }

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
          readOnly: _readOnly,
          canRequestFocus: !_readOnly,
          controller: widget.textEditingController,
          maxLength: _isMobileNumberField
              ? 13
              : (_isAuthenticationCodeField ? 6 : widget.maxLength),
          inputFormatters: _isMobileNumberField
              ? [
                  LibPhonenumberTextFormatter(
                    phoneNumberType: PhoneNumberType.fixedLine,
                    phoneNumberFormat: PhoneNumberFormat.national,
                    country: _phoneCode!,
                    inputContainsCountryCode: true,
                    additionalDigits: 3,
                  ),
                ]
              : (_isAuthenticationCodeField
                  ? [
                      LengthLimitingTextInputFormatter(6),
                    ]
                  : null),
          style: _isAuthenticationCodeField
              ? const TextStyle(
                  fontSize: 14,
                  letterSpacing: 6,
                )
              : null,
          keyboardType: _isAuthenticationCodeField ? TextInputType.text : null,
          cursorColor: Colors.black54,
          obscureText: _isPasswordField ? _obscureText : false,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: widget.focusNode.hasFocus
                ? ColorStyles.translucenceBlue
                : ColorStyles.textFieldBackground,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            prefixIcon: !widget.showPrefix
                ? null
                : (widget.type.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: widget.type.prefixIcon,
                      )
                    : null),
            suffix: widget.suffix,
            suffixIcon: _isPasswordField
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
                : (widget.type == TextFieldType.profileName ||
                        widget.type == TextFieldType.profileMobileNumber
                    ? IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _readOnly = !_readOnly;

                            if (_readOnly) {
                              widget.focusNode.unfocus();
                            } else {
                              widget.focusNode.requestFocus();
                            }
                          });
                        },
                      )
                    : widget.suffixIcon),
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
