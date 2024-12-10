import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/validator.dart';

class SignupViewModel with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();

  get emailController => _emailController;

  final TextEditingController _password1Controller = TextEditingController();

  get password1Controller => _password1Controller;

  final TextEditingController _password2Controller = TextEditingController();

  get password2Controller => _password2Controller;

  final TextEditingController _nameController = TextEditingController();

  get nameController => _nameController;

  final TextEditingController _mobileNumberController = TextEditingController();

  get mobileNumberController => _mobileNumberController;

  final FocusNode _emailFocusNode = FocusNode();

  get emailFocusNode => _emailFocusNode;

  final FocusNode _password1FocusNode = FocusNode();

  get password1FocusNode => _password1FocusNode;

  final FocusNode _password2FocusNode = FocusNode();

  get password2FocusNode => _password2FocusNode;

  final FocusNode _nameFocusNode = FocusNode();

  get nameFocusNode => _nameFocusNode;

  final FocusNode _mobileNumberFocusNode = FocusNode();

  get mobileNumberFocusNode => _mobileNumberFocusNode;

  String _passwordErrorMessage = '';

  String get passwordErrorMessage => _passwordErrorMessage;

  bool _isSignupButtonEnabled = false;

  bool get isSignupButtonEnabled => _isSignupButtonEnabled;

  SignupViewModel() {
    _emailController.addListener(_validateInputs);
    _password1Controller.addListener(_validateInputs);
    _password2Controller.addListener(_validateInputs);
    _nameController.addListener(_validateInputs);
    _mobileNumberController.addListener(_validateInputs);

    _password2Controller.addListener(() {
      _passwordErrorMessage = '';
    });
  }

  void _validateInputs() {
    final email = _emailController.text.trim();
    final password1 = _password1Controller.text.trim();
    final password2 = _password2Controller.text.trim();
    final name = _nameController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();

    _isSignupButtonEnabled = isValidEmail(email) &&
        isValidPassword(password1) &&
        isValidPassword(password2) &&
        name.isNotEmpty &&
        mobileNumber.replaceAll('-', '').length == 11 &&
        mobileNumber.startsWith('010');

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();

    _emailFocusNode.dispose();
    _password1FocusNode.dispose();
    _password2FocusNode.dispose();
  }

  Future<bool> signUp() async {
    final email = _emailController.text.trim();
    final password1 = _password1Controller.text.trim();
    final password2 = _password2Controller.text.trim();
    final name = _nameController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();

    if (password1 != password2) {
      _passwordErrorMessage = 'not_equal_password'.tr();
      notifyListeners();
      return false;
    }

    return true;
  }
}
