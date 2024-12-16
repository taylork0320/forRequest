import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/experiment/survey/survey_create_screen.dart';
import 'package:sasimee/styles/icons.dart';

import '../../../enums/experiment_item_view_option.dart';
import '../../../styles/color_styles.dart';
import '../widgets/survey_item.dart';

class SurveyExperimentView extends StatelessWidget {
  const SurveyExperimentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.layoutBackground,
      floatingActionButton: _createSurveyFloatingButton(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _recommendLayout(),
            const SizedBox(height: 24,),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _itemCountLayout(),
                  const Divider(height: 1, color: ColorStyles.dividerBackground,),
                  _fullLayout(),
                  _bottomPaginationLayout()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommendLayout() {
    return Container(
      color: ColorStyles.translucenceOrange,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("survey_screen_recommend_title".tr(),
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1.2
            ),
          ),
          const SizedBox(height: 5,),
          Text("recommend_description".tr(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorStyles.gray80,
            ),
          ),
          const SizedBox(height: 20,),
          ...List.generate(
            3, (index) => Column(
              children: [
                const SurveyItem(title: '이미지 생성형 AI 사용 목적 조사'),
                if (index != 2) const SizedBox(height: 16),
                // 마지막 아이템이 아닐 경우에만 간격 추가
              ],
            ),
          ),
          const SizedBox(height: 14,),
          _showMoreRecommendButton()
        ],
      ),
    );
  }

  //TODO: 버튼 클릭 시 더보기 & 접기 기능 추가
  Widget _showMoreRecommendButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorStyles.primaryOrange,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("recommend_more".tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8,),
          SvgIcons.arrowDown,
        ],
      ),
    );
  }

  Widget _itemCountLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Text(
          "item_count".tr(
              namedArgs: {"itemCount": 15.toString()}
          ),
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 14,
          color: ColorStyles.subText
        ),
      ),
    );
  }

  Widget _fullLayout() {
    return Column(
      children: [
        ...List.generate(
          10, (index) => Column(
            children: [
              SurveyItem(
                  viewType: ExperimentItemViewOption.FULL, title: '이미지 생성형 AI 사용 목적 조사'),
              const Divider(
                height: 1,
                color: ColorStyles.dividerBackground,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO: 페이지네이션 작업
  Widget _bottomPaginationLayout() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("1",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorStyles.primaryOrange,
            ),
          ),
          const SizedBox(width: 32,),
          Text("2",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorStyles.subText,
            ),
          ),
        ],
      ),
    );
  }

  // 설문 작성 플로팅 버튼
  Widget _createSurveyFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: FloatingActionButton.extended(
        onPressed: () {
          // 실험 작성 화면으로 이동
          Navigator.of(context).pushNamed(SurveyCreateScreen.routeName);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        label: Text("survey_add".tr(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600
            )),
        backgroundColor: ColorStyles.primaryOrange,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }
}