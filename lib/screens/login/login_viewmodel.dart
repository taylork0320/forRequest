import 'package:flutter/cupertino.dart';
import 'package:sasimee/repositories/auth_repository.dart';

import '../../utils/validator.dart';

class LoginViewModel with ChangeNotifier {
  late final AuthRepository _repository;

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
    _repository = AuthRepository();
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
    var requestLogin = await _repository.login(
        _emailController.text, _passwordController.text);

    // 로그인 실패
    if (requestLogin == null) {
      return false;
    }

    // Access Token 및 Refresh Token 저장
    _repository.saveAccessToken(requestLogin.accessToken);
    _repository.saveRefreshToken(requestLogin.refreshToken);

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
