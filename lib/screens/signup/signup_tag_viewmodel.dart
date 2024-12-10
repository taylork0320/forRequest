import 'package:flutter/cupertino.dart';

import '../../utils/constants.dart';

class SignupTagViewModel extends ChangeNotifier {
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
      // TODO: 다음 화면으로 이동
      _currentStep++;
      _isNextButtonEnabled = false;
      notifyListeners();
    }
  }

  void goToPreviousStep() {
    if (_currentStep > 0) {
      print('_selectedAgeGroups: $_selectedAgeGroups');
      _currentStep--;
      // 이전 단계의 버튼 활성화 조건 체크
      switch (_currentStep) {
        case 0: // 연령대 선택 화면
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
}
