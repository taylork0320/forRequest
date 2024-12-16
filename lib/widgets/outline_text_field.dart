import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class OutlineTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String? error;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;

  const OutlineTextField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    this.error,
    this.maxLength,
    this.maxLines,
    this.hintText,
  });

  @override
  State<OutlineTextField> createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
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
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: widget.focusNode.hasFocus
                ? ColorStyles.translucenceBlue
                : ColorStyles.textFieldBackground,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            hintStyle: const TextStyle(
                color: ColorStyles.hintText,
                fontSize: 14,
                letterSpacing: 1,
                fontWeight: FontWeight.w400),
            focusColor: ColorStyles.translucenceBlue,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(width: 1, color: ColorStyles.dividerBackground),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(width: 1, color: ColorStyles.primaryBlue),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(width: 5, color: ColorStyles.dividerBackground),
            ),
            hintText: widget.hintText,
            errorText: widget.error?.isNotEmpty == true ? widget.error : null,
            helperText: widget.error?.isEmpty == true ? '' : null,
          ),
        ),
      ),
    );
  }
}
