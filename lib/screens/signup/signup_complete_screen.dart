import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sasimee/screens/main/main_screen.dart';
import 'package:sasimee/styles/color_styles.dart';

class SignupCompleteScreen extends StatefulWidget {
  static String routeName = "/signup_complete";

  const SignupCompleteScreen({super.key});

  @override
  State<SignupCompleteScreen> createState() => _SignupCompleteScreenState();
}

class _SignupCompleteScreenState extends State<SignupCompleteScreen> {
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
                        'assets/images/graphics/img_sign_up_complete.png',
                        height: 200,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'welcome'.tr(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'welcome_description'.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _bottomHomeLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomHomeLayout() {
    return Column(
      children: [
        _homeButton(context),
        const SizedBox(height: 30),
        Visibility.maintain(child: _placeholder())
      ],
    );
  }

  Widget _homeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.routeName, (route) => false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyles.primaryBlue,
          ),
          child: Text('go_home'.tr())),
    );
  }

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