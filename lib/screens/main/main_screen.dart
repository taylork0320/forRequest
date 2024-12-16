import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/widgets/experiment_graphic_item.dart';
import 'package:sasimee/screens/main/widgets/perform_item.dart';
import 'package:sasimee/screens/main/widgets/survey_item.dart';
import 'package:sasimee/screens/mypage/mypage_main_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../enums/experiment_type.dart';
import '../../styles/color_styles.dart';
import '../../styles/icons.dart';
import 'experiment/experiment_screen.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Image> _bannerImages = [
    PngImages.bannerUserGuide,
    PngImages.bannerUserGuide,
    PngImages.bannerUserGuide
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          _appBar(),
          Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _bannerLayout(),
                  Positioned(
                      top: 155, // 배너와 겹치는 위치 조절
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _contentLayout()
                  )
                ],
              )
          ),
        ])
    );
  }

  Widget _appBar() {
    return AppBar(
      scrolledUnderElevation: 0, // 스크롤 시 앱바가 어두워지는 현상 제거
      backgroundColor: Colors.white,
      titleSpacing: 22, // 좌측 여백
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            height: 25,
            child: PngImages.logo
          ),
          const SizedBox(width: 13),
          SizedBox(
            height: 25,
            child: SvgIcons.textLogo,
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MypageMainScreen.routeName);
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
    );
  }

  Widget _bannerLayout() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            height: 180, // 배너 높이 지정
            child: PageView.builder(
              controller: _pageController,
              itemCount: _bannerImages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _bannerImages[index];
              },
            ),
          ),
          Positioned(
            top: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _bannerImages.length,
              effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: ColorStyles.layoutBackground,
                  activeDotColor: ColorStyles.primaryOrange),
            ),
          ),
        ],
      );
  }

  Widget _contentLayout() {
    return Container(
          decoration: const BoxDecoration(
            color: ColorStyles.layoutBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 24
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _surveyRecommendLayout(), // 추천하는 설문형 실험
                    const SizedBox(height: 32,),
                    _performRecommendLayout(), // 추천하는 실험형 실험
                    const SizedBox(height: 32,),
                    _graphicsLayout()
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _surveyRecommendLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("survey_recommend_title".tr(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            _detailButton(ExperimentType.survey)
          ],
        ),
        const SizedBox(height: 10,),
        ...List.generate(
          3, (index) => Column(
            children: [
              const SurveyItem(title: '이미지 생성형 AI 사용 목적 조사'),
              if (index != 2) const SizedBox(height: 16), // 마지막 아이템이 아닐 경우에만 간격 추가
            ],
          ),
        )
      ],
    );
  }

  Widget _performRecommendLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("perform_recommend_title".tr(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            _detailButton(ExperimentType.perform) // 전체 보기
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Flexible(
                flex: 1,
                child: PerformItem(title: 'Social\nExperiment 1')
            ),
            SizedBox(width: 12,),
            Flexible(
                flex: 1,
                child: PerformItem(title: 'Social\nExperiment 2')
            ),
          ],
        )
      ],
    );
  }

  Widget _detailButton(ExperimentType type) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context)
            .pushNamed(ExperimentScreen.routeName, arguments: type,);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("full_view".tr(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorStyles.gray70,
            ),
          ),
          const SizedBox(width: 6,),
          SizedBox(
            height: 10,
              child: SvgIcons.arrowRight
          )
        ],
      ),
    );
  }

  Widget _graphicsLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("create_experiment".tr(),
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Flexible(
                flex: 1,
                child: ExperimentGraphicItem(type: ExperimentType.survey)
            ),
            SizedBox(width: 20,),
            Flexible(
                flex: 1,
                child: ExperimentGraphicItem(type: ExperimentType.perform)
            ),
          ],
        ),
      ],
    );
  }
}