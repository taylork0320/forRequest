import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/enums/experiment_type.dart';
import 'package:sasimee/models/posting.dart';
import 'package:sasimee/screens/mypage/mypage_main_viewmodel.dart';
import 'package:sasimee/screens/mypage/mypage_profile_screen.dart';
import 'package:sasimee/screens/mypage/mypage_tag_screen.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/tag_item.dart';

class MypageMainScreen extends StatefulWidget {
  static String routeName = "/mypage";

  const MypageMainScreen({super.key});

  @override
  State<MypageMainScreen> createState() => _MypageMainScreenState();
}

class _MypageMainScreenState extends State<MypageMainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MypageMainViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('my_profile'.tr())),
        body: Builder(builder: (context) {
          final viewModel = Provider.of<MypageMainViewModel>(context);

          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _HeaderWidget(),
                Expanded(
                  child: PageView(
                    controller: viewModel.pageController,
                    children: const [
                      _ApplicationDetailsWidget(),
                      _RecruitmentDetailsWidget(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MypageMainViewModel>(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        top: 32,
        right: 24,
        bottom: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorStyles.dividerBackground,
                    width: 1,
                  ),
                  color: ColorStyles.progressBarBackground,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer<MypageMainViewModel>(
                        builder: (context, viewModel, _) {
                      return Text(
                        viewModel.profile?.name ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }),
                    const SizedBox(height: 5),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .pushNamed(MypageProfileScreen.routeName);

                                viewModel.refresh();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icons/ic_user.svg',
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    'profile_management'.tr(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: ColorStyles.subText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3.75,
                            ),
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: ColorStyles.subText,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(MypageTagScreen.routeName);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icons/ic_tag.svg',
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    'tag_management'.tr(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: ColorStyles.subText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Container(
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ColorStyles.progressBarBackground,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 4,
            ),
            child:
                Consumer<MypageMainViewModel>(builder: (context, viewModel, _) {
              final index = viewModel.index;

              return Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          viewModel.index = 0;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index == 0 ? ColorStyles.primaryBlue : null,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/ic_checkbox.svg',
                                colorFilter: index == 0
                                    ? const ColorFilter.mode(
                                        Colors.white, BlendMode.srcATop)
                                    : null,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'application_details'.tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: index == 0
                                      ? Colors.white
                                      : ColorStyles.subText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          viewModel.index = 1;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index == 1 ? ColorStyles.primaryBlue : null,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/ic_people.svg',
                                colorFilter: index == 1
                                    ? const ColorFilter.mode(
                                        Colors.white, BlendMode.srcATop)
                                    : null,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'recruitment_details'.tr(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: index == 1
                                      ? Colors.white
                                      : ColorStyles.subText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ApplicationDetailsWidget extends StatelessWidget {
  const _ApplicationDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MypageMainViewModel>(context);

    return StreamBuilder<List<Posting>>(
        stream: viewModel.applicationDetailsList,
        builder: (context, snapshot) {
          final posts = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                  child: Text(
                    "item_count"
                        .tr(namedArgs: {"itemCount": posts.length.toString()}),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorStyles.subText,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: ColorStyles.dividerBackground,
                ),
              ),
              SliverList.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _ItemWidget(posting: posts[index]);
                },
                separatorBuilder: (_, __) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: ColorStyles.dividerBackground,
                  );
                },
              )
            ],
          );
        });
  }
}

class _RecruitmentDetailsWidget extends StatelessWidget {
  const _RecruitmentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MypageMainViewModel>(context);

    return StreamBuilder<List<Posting>>(
        stream: viewModel.recruitmentDetailsList,
        builder: (context, snapshot) {
          final posts = snapshot.data ?? [];

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                  child: Text(
                    "item_count"
                        .tr(namedArgs: {"itemCount": posts.length.toString()}),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorStyles.subText,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: ColorStyles.dividerBackground,
                ),
              ),
              SliverList.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _ItemWidget(posting: posts[index]);
                },
                separatorBuilder: (_, __) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: ColorStyles.dividerBackground,
                  );
                },
              )
            ],
          );
        });
  }
}

class _ItemWidget extends StatelessWidget {
  final Posting posting;

  const _ItemWidget({super.key, required this.posting});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 24,
            right: 24,
            bottom: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const Text(
              //   '㈜네심이',
              //   style: TextStyle(
              //       fontSize: 11,
              //       fontWeight: FontWeight.w500,
              //       color: ColorStyles.subText),
              // ),
              // const SizedBox(height: 7),
              Text(
                posting.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 13),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: posting.tagName.map((e) {
                  return TagItem(
                    text: e,
                    type: ExperimentType.perform,
                    isPrimary: false,
                    isLarge: false,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
