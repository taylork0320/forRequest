import 'package:flutter/cupertino.dart';

import '../../utils/constants.dart';

class SignupViewModel extends ChangeNotifier {
  int _currentStep = 0; // 현재 회원가입 단계
  get currentStep => _currentStep;

  List<String> _selectedAgeGroups = [];
  get selectedAgeGroups => _selectedAgeGroups;

  bool _isNextButtonEnabled = false;
  get isNextButtonEnabled => _isNextButtonEnabled;

  void setCurrentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void setSelectedAgeGroups(List<String> ageGroups) {
    print('ageGroups: $ageGroups');
    _selectedAgeGroups = ageGroups;
    _isNextButtonEnabled = ageGroups.isNotEmpty;
    notifyListeners();
    print('_selectedAgeGroups: $_selectedAgeGroups');
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
      //TODO 다른 회원가입 단계들의 버튼 활성화 조건도 추가
      // case 1:
      //   _isNextButtonEnabled = 해당 단계의 조건;
      //   break;
        default:
          _isNextButtonEnabled = false;
      }
      notifyListeners();
    }
  }
}