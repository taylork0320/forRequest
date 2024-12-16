import 'package:flutter/cupertino.dart';

import '../../utils/validator.dart';

class MypageProfileViewModel with ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();

  TextEditingController get nameController => _nameController;

  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  final TextEditingController _mobileNumberController = TextEditingController();

  TextEditingController get mobileNumberController => _mobileNumberController;

  final FocusNode _nameFocusNode = FocusNode();

  FocusNode get nameFocusNode => _nameFocusNode;

  final FocusNode _emailFocusNode = FocusNode();

  FocusNode get emailFocusNode => _emailFocusNode;

  final FocusNode _mobileNumberFocusNode = FocusNode();

  FocusNode get mobileNumberFocusNode => _mobileNumberFocusNode;

  bool _isButtonEnabled = false;

  bool get isButtonEnabled => _isButtonEnabled;

  String? _profileUrl;

  String? get profileUrl => _profileUrl;

  set profileUrl(String? value) {
    if (_profileUrl != value) {
      _profileUrl = value;
      notifyListeners();
    }
  }

  MypageProfileViewModel() {
    _nameController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _mobileNumberController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();

    _isButtonEnabled = name.isNotEmpty &&
        isValidEmail(email) &&
        mobileNumber.replaceAll('-', '').length == 11 &&
        mobileNumber.startsWith('010');

    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileNumberFocusNode.dispose();

    super.dispose();
  }

  Future<bool> done() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final mobileNumber = _mobileNumberController.text.trim();

    return true;
  }
}
