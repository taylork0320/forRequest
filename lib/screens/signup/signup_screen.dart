import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/signup/signup_auth_screen.dart';
import 'package:sasimee/screens/signup/signup_viewmodel.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/widgets/common_text_field.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = "/login/register";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('register'.tr()),
        ),
        body: Builder(builder: (context) {
          final viewModel = Provider.of<SignupViewModel>(context);

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: mediaQuery.size.height -
                    mediaQuery.padding.top -
                    mediaQuery.padding.bottom -
                    kToolbarHeight,
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 57),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonTextField(
                              textEditingController: viewModel.emailController,
                              type: TextFieldType.email,
                              focusNode: viewModel.emailFocusNode,
                            ),
                            const SizedBox(height: 20),
                            CommonTextField(
                              textEditingController:
                                  viewModel.password1Controller,
                              type: TextFieldType.password,
                              focusNode: viewModel.password1FocusNode,
                            ),
                            const SizedBox(height: 20),
                            Consumer<SignupViewModel>(
                                builder: (context, viewModel, _) {
                              return CommonTextField(
                                textEditingController:
                                    viewModel.password2Controller,
                                type: TextFieldType.passwordConfirmation,
                                focusNode: viewModel.password2FocusNode,
                                error: viewModel.passwordErrorMessage,
                              );
                            }),
                            const SizedBox(height: 26),
                            CommonTextField(
                              textEditingController: viewModel.nameController,
                              type: TextFieldType.name,
                              focusNode: viewModel.nameFocusNode,
                            ),
                            const SizedBox(height: 20),
                            CommonTextField(
                              textEditingController:
                                  viewModel.mobileNumberController,
                              type: TextFieldType.mobileNumber,
                              focusNode: viewModel.mobileNumberFocusNode,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    _bottomLoginAndSignupLayout(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _bottomLoginAndSignupLayout() {
    return Consumer<SignupViewModel>(builder: (context, viewModel, _) {
      return Column(
        children: [
          _signupButton(viewModel, context),
          const SizedBox(height: 30),
          _loginButton(context)
        ],
      );
    });
  }

  Widget _signupButton(SignupViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            if (!viewModel.isSignupButtonEnabled) return;

            final result = viewModel.next();
            if (result != null) {
              Navigator.of(context).pushNamed(
                SignupAuthScreen.routeName,
                arguments: result,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: viewModel.isSignupButtonEnabled
                ? ColorStyles.primaryBlue
                : ColorStyles.dividerBackground,
          ),
          child: Text('signup'.tr())),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'already_have_member'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            // 로그인 화면으로 이동
            Navigator.of(context).pop();
          },
          child: Text(
            'login'.tr(),
            style: const TextStyle(
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
