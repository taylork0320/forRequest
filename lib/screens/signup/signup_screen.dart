import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/signup/signup_viewmodel.dart';
import 'package:sasimee/screens/signup/views/signup_tag_view.dart';
import 'package:sasimee/utils/constants.dart';

import '../../styles/color_styles.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (viewModel.currentStep > 0) {
                    viewModel.goToPreviousStep();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: (viewModel.currentStep + 1) / MAX_SIGNUP_STEP,
                          backgroundColor: ColorStyles.progressBarBackground,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 40),
                        _getStepContent(viewModel),
                      ],
                    ),
                    _bottomButtonLayout(context, viewModel),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getStepContent(SignupViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 0:
        return SignupTagView(); // 연령대 태그 선택
    //TODO: 회원가입 다른 단계들도 여기에 추가
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _bottomButtonLayout(BuildContext context, SignupViewModel viewModel) {
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: viewModel.isNextButtonEnabled
                ? () {
              viewModel.goToNextStep();
            }
                : null,
            child: Text('next'.tr()),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}