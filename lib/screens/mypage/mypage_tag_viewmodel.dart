import 'package:flutter/cupertino.dart';
import 'package:sasimee/models/user_tag.dart';
import 'package:sasimee/repositories/auth_repository.dart';

class MypageTagViewModel with ChangeNotifier {
  late final _repository = AuthRepository();
  var isInitialized = false;

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

  MypageTagViewModel() {
    _repository.getTag().then((tag) {
      _selectedAgeGroups = tag
          .where((e) => e.category == 'AGE_GROUP')
          .map((e) => e.name)
          .toList();

      _selectedAreaGroups =
          tag.where((e) => e.category == 'REGION').map((e) => e.name).toList();

      _selectedGenderGroups =
          tag.where((e) => e.category == 'GENDER').map((e) => e.name).toList();

      _selectedTypeGroups =
          tag.where((e) => e.category == 'CLASS').map((e) => e.name).toList();

      _selectedSubjectGroups =
          tag.where((e) => e.category == 'TOPIC').map((e) => e.name).toList();

      _validate();
      isInitialized = true;

      notifyListeners();
    });
  }

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

  Future<void> done() {
    final tag = [
      ..._selectedAgeGroups.map((e) => UserTag(name: e, category: 'AGE_GROUP')),
      ..._selectedAreaGroups.map((e) => UserTag(name: e, category: 'REGION')),
      ..._selectedGenderGroups.map((e) => UserTag(name: e, category: 'GENDER')),
      ..._selectedTypeGroups.map((e) => UserTag(name: e, category: 'CLASS')),
      ..._selectedSubjectGroups.map((e) => UserTag(name: e, category: 'TOPIC')),
    ];

    return _repository.modifyTag(tag);
  }
}
