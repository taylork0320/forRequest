import 'package:flutter/cupertino.dart';
import 'package:sasimee/models/request/auth/post_register_request.dart';
import 'package:sasimee/models/response/default_response.dart';
import 'package:sasimee/models/user_tag.dart';
import 'package:sasimee/repositories/auth_repository.dart';

import '../../utils/constants.dart';

class SignupTagViewModel extends ChangeNotifier {
  final PostRegisterRequest request;
  late final _repository = AuthRepository();

  int _currentStep = 0; // 현재 회원가입 단계
  get currentStep => _currentStep;

  List<String> _selectedAgeGroups = [];

  get selectedAgeGroups => _selectedAgeGroups;

  List<String> _selectedAreaGroups = [];

  get selectedAreaGroups => _selectedAreaGroups;

  List<String> _selectedGenderGroups = [];

  get selectedGenderGroups => _selectedGenderGroups;

  List<String> _selectedTypeGroups = [];

  get selectedTypeGroups => _selectedTypeGroups;

  List<String> _selectedSubjectGroups = [];

  get selectedSubjectGroups => _selectedSubjectGroups;

  bool _isNextButtonEnabled = false;

  get isNextButtonEnabled => _isNextButtonEnabled;

  SignupTagViewModel(this.request);

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void setSelectedAgeGroups(List<String> groups) {
    _selectedAgeGroups = groups;
    _isNextButtonEnabled = groups.isNotEmpty;
    notifyListeners();
  }

  void setSelectedAreaGroups(List<String> groups) {
    _selectedAreaGroups = groups;
    _isNextButtonEnabled = groups.isNotEmpty;
    notifyListeners();
  }

  void setSelectedGenderGroups(List<String> groups) {
    _selectedGenderGroups = groups;
    _isNextButtonEnabled = groups.isNotEmpty;
    notifyListeners();
  }

  void setSelectedTypeGroups(List<String> groups) {
    _selectedTypeGroups = groups;
    _isNextButtonEnabled = groups.isNotEmpty;
    notifyListeners();
  }

  void setSelectedSubjectGroups(List<String> groups) {
    _selectedSubjectGroups = groups;
    _isNextButtonEnabled = groups.isNotEmpty;
    notifyListeners();
  }

  void goToNextStep() {
    if (_currentStep < MAX_SIGNUP_STEP - 1) {
      _currentStep++;
      _updateNextButtonState();
      notifyListeners();
    }
  }

  void _updateNextButtonState() {
    switch (_currentStep) {
      case 0:
        _isNextButtonEnabled = _selectedAgeGroups.isNotEmpty;
        break;
      case 1:
        _isNextButtonEnabled = _selectedAreaGroups.isNotEmpty;
        break;
      case 2:
        _isNextButtonEnabled = _selectedGenderGroups.isNotEmpty;
        break;
      case 3:
        _isNextButtonEnabled = _selectedTypeGroups.isNotEmpty;
        break;
      case 4:
        _isNextButtonEnabled = _selectedSubjectGroups.isNotEmpty;
        break;
      default:
        _isNextButtonEnabled = false;
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      switch (_currentStep) {
        case 0:
          _isNextButtonEnabled = _selectedAgeGroups.isNotEmpty;
          break;
        case 1:
          _isNextButtonEnabled = _selectedAreaGroups.isNotEmpty;
          break;
        case 2:
          _isNextButtonEnabled = _selectedGenderGroups.isNotEmpty;
          break;
        case 3:
          _isNextButtonEnabled = _selectedTypeGroups.isNotEmpty;
          break;
        case 4:
          _isNextButtonEnabled = _selectedSubjectGroups.isNotEmpty;
          break;
        default:
          _isNextButtonEnabled = false;
      }
      notifyListeners();
    }
  }

  Future<DefaultResponse?> signUp() async {
    final request = PostRegisterRequest(
        email: this.request.email,
        password1: this.request.password1,
        password2: this.request.password2,
        name: this.request.name,
        phoneNumber: this.request.phoneNumber,
        tags: [
          ..._selectedAgeGroups
              .map((e) => UserTag(name: e, category: 'AGE_GROUP')),
          ..._selectedAreaGroups
              .map((e) => UserTag(name: e, category: 'REGION')),
          ..._selectedGenderGroups
              .map((e) => UserTag(name: e, category: 'GENDER')),
          ..._selectedTypeGroups
              .map((e) => UserTag(name: e, category: 'CLASS')),
          ..._selectedSubjectGroups
              .map((e) => UserTag(name: e, category: 'TOPIC')),
        ]);

    final response = await _repository.register(request);
    if (response?.status == true) {
      final response =
          await _repository.login(request.email, request.password1);

      if (response != null) {
        // Access Token 및 Refresh Token 저장
        _repository.saveAccessToken(response.accessToken);
        _repository.saveRefreshToken(response.refreshToken);
      }
    }

    return response;
  }
}
