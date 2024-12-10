import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/screens/login/login_screen.dart';
import 'package:sasimee/screens/login/login_viewmodel.dart';
import 'package:sasimee/screens/main/experiment/experiment_screen.dart';
import 'package:sasimee/screens/main/main_screen.dart';
import 'package:sasimee/screens/signup/signup_screen.dart';
import 'package:sasimee/styles/color_styles.dart';

import 'enums/experiment_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ],
    child: EasyLocalization(
      supportedLocales: const [Locale('ko')], // 지원 언어 목록
      path: 'assets/translations', // 번역 파일 위치
      fallbackLocale: const Locale('ko'), // 기본 언어 설정
      child: SasimeeApp(),
    ),
  ));
}

/// 라우팅 설정 (pushNamed를 통해 쉽게 화면 라우팅을 할 수 있다)
final route = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  ExperimentScreen.routeName: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ExperimentType;
    return ExperimentScreen(type: args);
  },
};

class SasimeeApp extends StatelessWidget {
  const SasimeeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.white);

    return MaterialApp(
      title: 'app_name'.tr(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: "Pretendard",
        primaryColor: ColorStyles.primaryBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              foregroundColor: Colors.white,
              backgroundColor: ColorStyles.primaryBlue,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      initialRoute: LoginScreen.routeName,
      routes: route,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
