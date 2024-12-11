import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:sasimee/utils/validator.dart';

class PasswordResetViewModel with ChangeNotifier {
  final TextEditingController _password1Controller = TextEditingController();

  get password1Controller => _password1Controller;

  final TextEditingController _password2Controller = TextEditingController();

  get password2Controller => _password2Controller;

  final FocusNode _password1FocusNode = FocusNode();

  get password1FocusNode => _password1FocusNode;

  final FocusNode _password2FocusNode = FocusNode();

  get password2FocusNode => _password2FocusNode;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool _isButtonEnabled = false;

  bool get isButtonEnabled => _isButtonEnabled;

  PasswordResetViewModel() {
    _password1Controller.addListener(_validateInputs);
    _password2Controller.addListener(_validateInputs);

    _password2Controller.addListener(() {
      _errorMessage = '';
    });
  }

  void _validateInputs() {
    _isButtonEnabled = isValidPassword(_password1Controller.text.trim()) &&
        isValidPassword(_password2Controller.text.trim());
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _password1Controller.dispose();
    _password2Controller.dispose();

    _password1FocusNode.dispose();
    _password2FocusNode.dispose();
  }

  Future<bool> done() async {
    final password1 = _password1Controller.text.trim();
    final password2 = _password2Controller.text.trim();

    if (password1 != password2) {
      _errorMessage = 'not_equal_password'.tr();
      notifyListeners();
      return false;
    }

    return true;
  }
}
