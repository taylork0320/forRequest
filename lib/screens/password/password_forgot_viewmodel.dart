import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sasimee/utils/validator.dart';

class PasswordForgotViewModel with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();

  get emailController => _emailController;

  final FocusNode _emailFocusNode = FocusNode();

  get emailFocusNode => _emailFocusNode;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool _isButtonEnabled = false;

  bool get isButtonEnabled => _isButtonEnabled;

  PasswordForgotViewModel() {
    _emailController.addListener(_validateInputs);
    _emailController.addListener(() {
      _errorMessage = '';
    });
  }

  void _validateInputs() {
    _isButtonEnabled = isValidEmail(_emailController.text.trim());
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _emailFocusNode.dispose();
  }

  Future<bool> requestOtp() async {
    final email = _emailController.text.trim();

    // if (입력된 email 로 가입된 계정이 없다면) {
    //   _errorMessage = 'invalid_account'.tr();
    //   notifyListeners();
    //   return false;
    // }

    return true;
  }
}
