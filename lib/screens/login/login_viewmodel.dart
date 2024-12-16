import 'package:flutter/cupertino.dart';

import '../../utils/validator.dart';

class LoginViewModel with ChangeNotifier {

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
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
    _emailFocusNode.addListener(_onFocusChange);
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}