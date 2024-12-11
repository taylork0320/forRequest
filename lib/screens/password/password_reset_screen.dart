import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/password/password_reset_complete_screen.dart';
import 'package:sasimee/screens/password/password_reset_viewmodel.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/common_text_field.dart';

class PasswordResetScreen extends StatefulWidget {
  static String routeName = "/password_reset";

  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ChangeNotifierProvider(
      create: (_) => PasswordResetViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('new_password'.tr())),
        body: Builder(builder: (context) {
          final viewModel = Provider.of<PasswordResetViewModel>(context);

          return SafeArea(
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
                            'password_reset_guide'.tr(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 53),
                          Text(
                            'new_password'.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          CommonTextField(
                            textEditingController:
                                viewModel.password1Controller,
                            type: TextFieldType.password,
                            focusNode: viewModel.password1FocusNode,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'new_password_confirmation'.tr(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Consumer<PasswordResetViewModel>(
                              builder: (context, viewModel, _) {
                            return CommonTextField(
                              textEditingController:
                                  viewModel.password2Controller,
                              type: TextFieldType.passwordConfirmation,
                              focusNode: viewModel.password2FocusNode,
                              error: viewModel.errorMessage,
                            );
                          }),
                        ],
                      ),
                    ),
                    _bottomDoneLayout(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// 완료 버튼 레이아웃을 리턴합니다.
  Widget _bottomDoneLayout() {
    return Consumer<PasswordResetViewModel>(builder: (context, viewModel, _) {
      return Column(
        children: [
          _doneButton(viewModel, context),
          const SizedBox(height: 30),
          Visibility.maintain(child: _placeholder())
        ],
      );
    });
  }

  /// 인증번호 요청 버튼 위젯을 리턴합니다.
  Widget _doneButton(PasswordResetViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            if (!viewModel.isButtonEnabled) return;

            if (await viewModel.done()) {
              if (!context.mounted) return;
              Navigator.of(context)
                  .pushNamed(PasswordResetCompleteScreen.routeName);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: viewModel.isButtonEnabled
                ? ColorStyles.primaryBlue
                : ColorStyles.dividerBackground,
          ),
          child: Text('done'.tr())),
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
