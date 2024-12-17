import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sasimee/models/request/auth/post_token_reissue_request.dart';
import 'package:sasimee/screens/login/login_screen.dart';
import 'package:sasimee/screens/login/login_viewmodel.dart';
import 'package:sasimee/screens/main/experiment/experiment_screen.dart';
import 'package:sasimee/screens/main/experiment/perform/perform_create_screen.dart';
import 'package:sasimee/screens/main/experiment/perform/perform_info_screen.dart';
import 'package:sasimee/screens/main/experiment/survey/survey_create_screen.dart';
import 'package:sasimee/screens/main/experiment/survey/survey_inspect_screen.dart';
import 'package:sasimee/screens/main/main_screen.dart';
import 'package:sasimee/screens/mypage/mypage_main_screen.dart';
import 'package:sasimee/screens/mypage/mypage_profile_screen.dart';
import 'package:sasimee/screens/mypage/mypage_tag_screen.dart';
import 'package:sasimee/screens/signup/signup_auth_screen.dart';
import 'package:sasimee/screens/signup/signup_screen.dart';
import 'package:sasimee/screens/signup/signup_tag_screen.dart';
import 'package:sasimee/screens/signup/signup_complete_screen.dart';
import 'package:sasimee/services/api/auth_api.dart';
import 'package:sasimee/services/data/secure_storage_service.dart';
import 'package:sasimee/services/network/dio_service.dart';
import 'package:sasimee/styles/color_styles.dart';
import 'package:sasimee/utils/constants.dart';
import 'enums/experiment_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }

  final FlutterSecureStorage secureStorage = SecureStorageService().get();
  final AuthApi client = AuthApi(DioService().get());

  Future<bool> isLoggedIn() async {
    // Access Token이 Storage에 없을 경우 false
    if (!(await secureStorage.containsKey(key: ACCESS_TOKEN_STORAGE_KEY))) {
      return false;
    }

    String? accessToken =
        await secureStorage.read(key: ACCESS_TOKEN_STORAGE_KEY);
    String? refreshToken =
        await secureStorage.read(key: REFRESH_TOKEN_STORAGE_KEY);

    try {
      if (accessToken != null) {
        var response = await client.postTokenReissue(PostTokenReissueRequest(
            accessToken: accessToken, refreshToken: refreshToken.toString()));
        print("자동 로그인 성공");
        //TODO: 응답 성공 여부 판단 필요
        return true;
      }
    } catch (e) {
      print("자동 로그인 실패, $e");
      return false;
    }

    return false;
  }

  bool checkLoginResult = await isLoggedIn();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ],
    child: EasyLocalization(
      supportedLocales: const [Locale('ko')], // 지원 언어 목록
      path: 'assets/translations', // 번역 파일 위치
      fallbackLocale: const Locale('ko'), // 기본 언어 설정
      child: SasimeeApp(
        isLoggedIn: checkLoginResult,
      ),
    ),
  ));
}

/// 라우팅 설정 (pushNamed를 통해 쉽게 화면 라우팅을 할 수 있다)
final route = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  SignupAuthScreen.routeName: (context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return SignupAuthScreen(email: email);
  },
  SignupTagScreen.routeName: (context) => const SignupTagScreen(),
  SignupCompleteScreen.routeName: (context) => const SignupCompleteScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  ExperimentScreen.routeName: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as ExperimentType;
    return ExperimentScreen(type: args);
  },
  SurveyCreateScreen.routeName: (context) => const SurveyCreateScreen(),
  SurveyInspectScreen.routeName: (context) => const SurveyInspectScreen(),
  PerformCreateScreen.routeName: (context) => const PerformCreateScreen(),
  PerformInfoScreen.routeName: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return PerformInfoScreen(title: args);
  },
  MypageMainScreen.routeName: (context) => const MypageMainScreen(),
  MypageProfileScreen.routeName: (context) => const MypageProfileScreen(),
  MypageTagScreen.routeName: (context) => const MypageTagScreen(),
};

class SasimeeApp extends StatelessWidget {
  final bool isLoggedIn;

  const SasimeeApp({super.key, required this.isLoggedIn});

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
      initialRoute: isLoggedIn ? MainScreen.routeName : LoginScreen.routeName,
      routes: route,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
