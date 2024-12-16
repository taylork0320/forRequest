import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class CommonDialog extends StatelessWidget {
  final Widget? dialogImageWidget;
  final String title;
  final TextStyle titleTextStyle;
  final String? description;
  final TextStyle descriptionTextStyle;
  final List<Widget> buttonWidgetList;

  const CommonDialog({
    super.key,
    required this.title,
    this.description,
    required this.buttonWidgetList,
    this.dialogImageWidget,
    this.titleTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    this.descriptionTextStyle = const TextStyle(fontSize: 14),
  });

  static List<Widget> cancelOkButton(
      BuildContext context, Function() onClickOk) {
    return [
      Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              backgroundColor: ColorStyles.gray70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Text("cancel".tr(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          )),
      const SizedBox(width: 8),
      Expanded(
          child: ElevatedButton(
            onPressed: () {
              onClickOk();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              backgroundColor: ColorStyles.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Text("ok".tr(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ))
    ];
  }

  static List<Widget> okButton(BuildContext context, Function()? onClickOk) {
    return [
      Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (onClickOk != null) onClickOk();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              backgroundColor: ColorStyles.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Text("ok".tr(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (dialogImageWidget != null) dialogImageWidget!,
                    if (dialogImageWidget != null) const SizedBox(height: 20),
                    Text(
                      title,
                      style: titleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    if (description != null) const SizedBox(height: 8),
                    if (description != null)
                      Text(
                        description!,
                        style: descriptionTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: buttonWidgetList,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
