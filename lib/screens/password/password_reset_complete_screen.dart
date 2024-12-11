import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/login/login_screen.dart';
import 'package:sasimee/styles/color_styles.dart';

class PasswordResetCompleteScreen extends StatefulWidget {
  static String routeName = "/password_reset_complete";

  const PasswordResetCompleteScreen({super.key});

  @override
  State<PasswordResetCompleteScreen> createState() =>
      _PasswordResetCompleteScreenState();
}

class _PasswordResetCompleteScreenState
    extends State<PasswordResetCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              bottom: 57,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/graphics/img_secure_shield.png',
                        height: 200,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'password_reset_complete'.tr(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'password_reset_complete_description'.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _bottomLoginLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 로그인 버튼 레이아웃을 리턴합니다.
  Widget _bottomLoginLayout() {
    return Column(
      children: [
        _homeButton(context),
        const SizedBox(height: 30),
        Visibility.maintain(child: _placeholder())
      ],
    );
  }

  /// 로그인 버튼 위젯을 리턴합니다.
  Widget _homeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            Navigator.popUntil(context, (route) {
              if (route.settings.name == LoginScreen.routeName) {
                return true;
              }

              return false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyles.primaryBlue,
          ),
          child: Text('login'.tr())),
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
