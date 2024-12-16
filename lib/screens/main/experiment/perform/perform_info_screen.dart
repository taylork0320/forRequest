import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/experiment/perform/views/perform_detail_view.dart';
import 'package:sasimee/screens/main/experiment/perform/views/perform_experimenter_info_view.dart';
import 'package:sasimee/screens/main/experiment/perform/views/perform_tag_view.dart';
import 'package:sasimee/styles/color_styles.dart';

class PerformInfoScreen extends StatelessWidget {
  static String routeName = "/perform-info";
  final String title;

  const PerformInfoScreen({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: _appBar(),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      /// 실험 내용
                      _performInfoLayout(),
                      const SizedBox(height: 36),
                      /// 탭바
                      _tabBar(),
                      /// TabBarView
                      const Expanded(
                        child: TabBarView(
                          children: [
                            PerformDetailView(), // 상세 내용
                            PerformTagView(), // 태그 목록
                            PerformExperimenterInfoView() // 실험자 정보
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6,),
                _doneButton(),
              ],
            ),
          ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      scrolledUnderElevation: 0, // 스크롤 시 앱바가 어두워지는 현상 제거
      backgroundColor: Colors.white,
      title: Text('perform_information'.tr(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget _performInfoLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 18,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //TODO: 이미지 추가
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: ColorStyles.dividerBackground),
                color: ColorStyles.textFieldBackground
              ),
            ),
            const SizedBox(width: 12,),
            Text("가천대학교 연구실",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),
            ),
          ],
        )
      ],
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
        Tab(text: '상세 내용'),
        Tab(text: '태그 목록'),
        Tab(text: '실험자 정보'),
      ],
    );
  }

  //TODO: 지원 여부, 작성자 여부에 따른 버튼 변경
  Widget _doneButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: ColorStyles.primaryBlue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text("apply".tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}