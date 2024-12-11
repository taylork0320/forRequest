import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/password/password_auth_screen.dart';
import 'package:sasimee/screens/password/password_forgot_viewmodel.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/common_text_field.dart';

class PasswordForgotScreen extends StatefulWidget {
  static String routeName = "/password_reset";

  const PasswordForgotScreen({super.key});

  @override
  State<PasswordForgotScreen> createState() => _PasswordForgotScreenState();
}

class _PasswordForgotScreenState extends State<PasswordForgotScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ChangeNotifierProvider(
      create: (_) => PasswordForgotViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('find_password'.tr())),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: mediaQuery.size.height -
                  mediaQuery.padding.top -
                  mediaQuery.padding.bottom -
                  kToolbarHeight,
              padding: const EdgeInsets.only(
                left: 32,
                top: 53,
                right: 32,
                bottom: 57,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'trouble_log_in'.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'find_password_guide'.tr(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 53),
                        Consumer<PasswordForgotViewModel>(
                            builder: (context, viewModel, _) {
                          return CommonTextField(
                            textEditingController: viewModel.emailController,
                            type: TextFieldType.email,
                            focusNode: viewModel.emailFocusNode,
                            error: viewModel.errorMessage,
                          );
                        }),
                      ],
                    ),
                  ),
                  _bottomOtpRequestLayout(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 인증번호 요청 버튼 레이아웃을 리턴합니다.
  Widget _bottomOtpRequestLayout() {
    return Consumer<PasswordForgotViewModel>(builder: (context, viewModel, _) {
      return Column(
        children: [
          _otpRequestButton(viewModel, context),
          const SizedBox(height: 30),
          Visibility.maintain(child: _placeholder())
        ],
      );
    });
  }

  /// 인증번호 요청 버튼 위젯을 리턴합니다.
  Widget _otpRequestButton(
      PasswordForgotViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            if (!viewModel.isButtonEnabled) return;

            if (await viewModel.requestOtp()) {
              if (!context.mounted) return;
              Navigator.of(context).pushNamed(PasswordAuthScreen.routeName);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: viewModel.isButtonEnabled
                ? ColorStyles.primaryBlue
                : ColorStyles.dividerBackground,
          ),
          child: Text('request_authentication_number'.tr())),
    );
  }

  /// 회원 가입 화면과 버튼의 위치를 일치시키기 위한 Placeholder 위젯을 리턴합니다.
  Widget _placeholder() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: null,
          child: Text(
            '',
            style: TextStyle(
              color: ColorStyles.primaryBlue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: ColorStyles.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }
}
