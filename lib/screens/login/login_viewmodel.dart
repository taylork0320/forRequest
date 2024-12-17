import 'package:flutter/cupertino.dart';

import '../../repositories/login_repository.dart';
import '../../utils/validator.dart';

class LoginViewModel with ChangeNotifier {

  late final LoginRepository _loginRepository;

  final TextEditingController _emailController = TextEditingController();
  get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  get passwordController => _passwordController;

  final FocusNode _emailFocusNode = FocusNode();
  get emailFocusNode => _emailFocusNode;

  final FocusNode _passwordFocusNode = FocusNode();
  get passwordFocusNode => _passwordFocusNode;

  bool _isLoginButtonEnabled = false;
  bool get isLoginButtonEnabled => _isLoginButtonEnabled;

  LoginViewModel() {
    _loginRepository = LoginRepository();
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _emailFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  /// 로그인 진행
  Future<bool> login() async {
    var requestLogin = await _loginRepository.login(_emailController.text, _passwordController.text);

    // 로그인 실패
    if (requestLogin == null) {
      return false;
    }

    // Access Token 및 Refresh Token 저장
    _loginRepository.saveAccessToken(requestLogin.accessToken);
    _loginRepository.saveRefreshToken(requestLogin.refreshToken);

    return true;
  }

  void _validateInputs() {
    final email = _emailController.text;
    final password = _passwordController.text;

    _isLoginButtonEnabled = isValidEmail(email) && isValidPassword(password);
    notifyListeners();
  }

  void _onFocusChange() {
    notifyListeners();
  }
}