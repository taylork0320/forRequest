import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/login/login_viewmodel.dart';
import 'package:sasimee/screens/main/main_screen.dart';
import 'package:sasimee/screens/signup/signup_screen.dart';
import 'package:sasimee/styles/icons.dart';

import '../../styles/color_styles.dart';
import '../../widgets/common_text_field.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: mediaQuery.size.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom,
            padding: const EdgeInsets.only(
                left: 32, top: 107, right: 32, bottom: 57),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appDescriptionLayout(),
                const SizedBox(height: 70),
                _contentInputLayout(loginViewModel),
                const Spacer(),
                _bottomLoginAndSignupLayout(loginViewModel, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appDescriptionLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: PngImages.logo,
        ),
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          width: 126,
          height: 38,
          child: SvgIcons.textLogo,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'login_app_description'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _contentInputLayout(LoginViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CommonTextField(
          textEditingController: viewModel.emailController,
          type: TextFieldType.email,
          focusNode: viewModel.emailFocusNode,
        ),
        const SizedBox(
          height: 20,
        ),
        CommonTextField(
          textEditingController: viewModel.passwordController,
          type: TextFieldType.password,
          focusNode: viewModel.passwordFocusNode,
        ),
        const SizedBox(
          height: 6,
        ),
        TextButton(
          onPressed: () {
            //TODO: 비밀번호 찾기 페이지로 이동
            print("비밀번호 찾기 버튼 클릭");
          },
          child: Text(
            'forget_password'.tr(),
            style: const TextStyle(
              color: ColorStyles.hintText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  Widget _bottomLoginAndSignupLayout(
      LoginViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        _loginButton(viewModel, context),
        const SizedBox(
          height: 30,
        ),
        _signupButton(context)
      ],
    );
  }

  Widget _loginButton(LoginViewModel viewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            viewModel.isLoginButtonEnabled
                ? Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.routeName, (route) => false)
                : null;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: viewModel.isLoginButtonEnabled
                ? ColorStyles.primaryBlue
                : ColorStyles.dividerBackground,
          ),
          child: Text('login'.tr())),
    );
  }

  Widget _signupButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'not_yet_member'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            // 회원가입 화면으로 이동
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          },
          child: Text(
            'signup'.tr(),
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
