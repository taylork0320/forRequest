import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/experiment/perform/perform_create_screen.dart';
import 'package:sasimee/screens/main/experiment/survey/survey_create_screen.dart';
import 'package:sasimee/styles/icons.dart';

import '../../../enums/experiment_type.dart';

class ExperimentGraphicItem extends StatelessWidget {
  final ExperimentType type; //TODO: Perform 데이터로 변경

  const ExperimentGraphicItem({
    super.key,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: type.tagBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15, horizontal: 18
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _graphicImage(),
          const SizedBox(height: 17,),
          _description(),
          const SizedBox(height: 17,),
          _bottomButton(context)
        ],
      ),
    );
  }

  Widget _graphicImage() {
    return Center(
      child: SizedBox(
          width: 80,
          height: 80,
          child: type == ExperimentType.survey
              ? PngImages.surveyGraphic
              : PngImages.performGraphic
      ),
    );
  }

  Widget _description() {
    return Text(type == ExperimentType.survey
        ? 'survey_description'.tr()
        : 'perform_description'.tr(),
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 16
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: GestureDetector(
        onTap: (){
          type == ExperimentType.survey
              ? Navigator.pushNamed(context, SurveyCreateScreen.routeName) // 설문 생성
              : Navigator.pushNamed(context, PerformCreateScreen.routeName); // 수행 생성
        },
        child: Row(
          children: [
            Expanded(
              child: Text(type == ExperimentType.survey
                  ? "survey_create".tr()
                  : "perform_create".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.black
                ),
              ),
            ),
            SvgIcons.arrowDotted
          ],
        ),
      ),
    );
  }
}