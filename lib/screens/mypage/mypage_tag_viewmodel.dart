import 'package:flutter/cupertino.dart';

class MypageTagViewModel with ChangeNotifier {
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

  bool _isButtonEnabled = false;

  get isButtonEnabled => _isButtonEnabled;

  MypageTagViewModel();

  @override
  void dispose() {
    super.dispose();
  }

  void setSelectedAgeGroups(List<String> groups) {
    _selectedAgeGroups = groups;
    _validate();
    notifyListeners();
  }

  void setSelectedAreaGroups(List<String> groups) {
    _selectedAreaGroups = groups;
    _validate();
    notifyListeners();
  }

  void setSelectedGenderGroups(List<String> groups) {
    _selectedGenderGroups = groups;
    _validate();
    notifyListeners();
  }

  void setSelectedTypeGroups(List<String> groups) {
    _selectedTypeGroups = groups;
    _validate();
    notifyListeners();
  }

  void setSelectedSubjectGroups(List<String> groups) {
    _selectedSubjectGroups = groups;
    _validate();
    notifyListeners();
  }

  void _validate() {
    _isButtonEnabled = _selectedAgeGroups.isNotEmpty &&
        _selectedAreaGroups.isNotEmpty &&
        _selectedGenderGroups.isNotEmpty &&
        _selectedTypeGroups.isNotEmpty &&
        _selectedSubjectGroups.isNotEmpty;
  }

  Future<bool> done() async {
    return true;
  }
}