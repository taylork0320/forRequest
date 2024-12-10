import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/signup/signup_complete_screen.dart';
import 'package:sasimee/screens/signup/signup_tag_viewmodel.dart';
import 'package:sasimee/screens/signup/views/signup_age_tag.dart';
import 'package:sasimee/screens/signup/views/signup_area_tag.dart';
import 'package:sasimee/screens/signup/views/signup_gender_tag.dart';
import 'package:sasimee/screens/signup/views/signup_subject_tag.dart';
import 'package:sasimee/screens/signup/views/signup_type_tag.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/utils/constants.dart';

class SignupTagScreen extends StatelessWidget {
  static String routeName = "/signup_tag";

  const SignupTagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupTagViewModel(),
      child: Builder(builder: (context) {
        final viewModel = Provider.of<SignupTagViewModel>(context);

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;

            if (viewModel.currentStep == 0) {
              if (Navigator.canPop(context)) Navigator.of(context).pop();
            } else {
              viewModel.goToPreviousStep();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 32, top: 20, right: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: (viewModel.currentStep + 1) / MAX_SIGNUP_STEP,
                      backgroundColor: ColorStyles.progressBarBackground,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: Consumer<SignupTagViewModel>(
                          builder: (context, viewModel, _) {
                        return IndexedStack(
                          index: viewModel.currentStep,
                          children: const [
                            SignupAgeTag(),
                            SignupAreaTag(),
                            SignupGenderTag(),
                            SignupTypeTag(),
                            SignupSubjectTag(),
                          ],
                        );
                      }),
                    ),
                    _bottomButtonLayout(context, viewModel),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 다음 및 선택완료 버튼 레이아웃을 리턴합니다.
  Widget _bottomButtonLayout(
      BuildContext context, SignupTagViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'signup_tag_guide'.tr(),
          style: const TextStyle(
            color: ColorStyles.guideText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 18),
        Consumer<SignupTagViewModel>(builder: (context, viewModel, _) {
          bool isLast = viewModel.currentStep == (MAX_SIGNUP_STEP - 1);

          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: viewModel.isNextButtonEnabled
                  ? () {
                      if (isLast) {
                        Navigator.of(context)
                            .pushNamed(SignupCompleteScreen.routeName);
                      } else {
                        viewModel.goToNextStep();
                      }
                    }
                  : null,
              child: Text(isLast ? 'selection_complete'.tr() : 'next'.tr()),
            ),
          );
        }),
        const SizedBox(height: 60),
      ],
    );
  }
}
