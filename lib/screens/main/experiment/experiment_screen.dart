import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/experiment/perform_experiment_view.dart';
import 'package:sasimee/screens/main/experiment/survey_experiment_view.dart';
import 'package:sasimee/styles/color_styles.dart';

import '../../../enums/experiment_type.dart';
import '../../../styles/icons.dart';

class ExperimentScreen extends StatelessWidget {
  static String routeName = "/experiment";

  final ExperimentType type;

  const ExperimentScreen({
    super.key,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: type == ExperimentType.survey ? 0 : 1,
      child: Scaffold(
        appBar: _appBar(),
        body: const TabBarView(
          children: [
            SurveyExperimentView(), // 설문형
            PerformExperimentView(), // 수행형
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      scrolledUnderElevation: 0, // 스크롤 시 앱바가 어두워지는 현상 제거
      backgroundColor: Colors.white,
      titleSpacing: 22, // 좌측 여백
      title: Center(
        child: SizedBox(
          width: 28,
          height: 25,
          child: Image.asset('assets/images/sasimee_logo.png'),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              //TODO: 마이페이지로 이동
            },
            child: SizedBox(
              width: 30,
              height: 30,
              child: SvgIcons.profile,
            ),
          ),
        ),
        const SizedBox(width: 12) // 우측 여백
      ],
      bottom: _tabBar(),
    );
  }

  PreferredSizeWidget _tabBar() {
    return const TabBar(
      indicatorColor: ColorStyles.primaryBlue,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: ColorStyles.primaryBlue,
      labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600
      ),
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
      ),
      tabs: [
        Tab(text: '설문형'),
        Tab(text: '수행형'),
      ],
    );
  }
}