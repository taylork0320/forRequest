import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/experiment/perform/perform_create_screen.dart';
import 'package:sasimee/screens/main/widgets/perform_large_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../styles/color_styles.dart';
import '../widgets/perform_item.dart';

class PerformExperimentView extends StatefulWidget {
  const PerformExperimentView({super.key});

  @override
  State<PerformExperimentView> createState() => _PerformExperimentViewState();
}

class _PerformExperimentViewState extends State<PerformExperimentView> {
  final PageController _recommendPageController = PageController();
  int _currentRecommendPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.layoutBackground,
      floatingActionButton: _createPerformFloatingButton(context),
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
      width: double.infinity,
      color: ColorStyles.translucenceBlue,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("perform_screen_recommend_title".tr(),
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
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: SizedBox(
              height: 205,
              child: PageView.builder(
                  controller: _recommendPageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentRecommendPage = index;
                    });
                  },
                  itemCount: 3, // 페이지 수
                  padEnds: false, // 마지막 페이지 패딩 제거
                  pageSnapping: true, // 페이지 스냅 효과 활성화
                  itemBuilder: (context, pageIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: PerformItem(
                                  title: 'Social\nExperiment ${pageIndex * 2 + 1}')),
                          const SizedBox(width: 12,),
                          Flexible(
                              flex: 1,
                              child: PerformItem(
                                  title: 'Social\nExperiment ${pageIndex * 2 + 2}')),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: _recommendPageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: ColorStyles.subText,
                    activeDotColor: ColorStyles.primaryBlue),
              ),
            ],
          ),
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
        style: const TextStyle(
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
              PerformLargeItem(title: '사회 실험에 참여할 사람을 모집합니다.'),
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
              color: ColorStyles.primaryBlue,
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

  // 실험 작성 플로팅 버튼
  Widget _createPerformFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: FloatingActionButton.extended(
        onPressed: () {
          // 실험 작성 화면으로 이동
          Navigator.of(context).pushNamed(PerformCreateScreen.routeName);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        label: Text("survey_add".tr(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600
            )),
        backgroundColor: ColorStyles.primaryBlue,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }
}