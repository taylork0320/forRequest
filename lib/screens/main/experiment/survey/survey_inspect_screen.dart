import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/widgets/outline_text_field.dart';

import '../../../../styles/color_styles.dart';
import '../../../../widgets/common_dialog.dart';

class SurveyInspectScreen extends StatelessWidget {
  static String routeName = "/survey-inspect";

  const SurveyInspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _surveyInspectLayout(),
            Column(
              children: [
                _inspectionButton(context),
                const SizedBox(height: 139,),
              ],
            )
          ],
        )
      ),
    );
  }

  Widget _surveyInspectLayout() {
    TextEditingController titleController = TextEditingController();
    final FocusNode titleFocusNode = FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("survey_link".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        OutlineTextField(textEditingController: titleController, focusNode: titleFocusNode),
        const SizedBox(height: 32,),
        Text("survey_inspection_guide".tr(),
          style: const TextStyle(
            color: ColorStyles.subText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 22,),
        Text("survey_inspection_criteria".tr(),
          style: const TextStyle(
              color: ColorStyles.subText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 2
          ),
        ),
      ],
    );
  }

  //TODO: 설문 검수 진행
  Widget _inspectionButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: 유효하지 않은 주소일 경우 다이얼로그 노출
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return CommonDialog(
                  title: "survey_inspect_dialog_title".tr(),
                  description: "survey_inspect_dialog_description".tr(),
                  buttonWidgetList: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                  ]);
            });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: ColorStyles.primaryBlue,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          "survey_do_inspect".tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}