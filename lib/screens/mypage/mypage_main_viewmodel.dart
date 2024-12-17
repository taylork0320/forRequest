import 'package:flutter/cupertino.dart';
import 'package:sasimee/models/response/mypage/profile_response.dart';
import 'package:sasimee/repositories/auth_repository.dart';

class MypageMainViewModel with ChangeNotifier {
  late final _repository = AuthRepository();
  late final _pageController = PageController();

  PageController get pageController => _pageController;

  int get index =>
      pageController.hasClients ? (pageController.page?.toInt() ?? 0) : 0;

  set index(int value) {
    if (index != value) {
      pageController.jumpToPage(value);
      notifyListeners();
    }
  }

  FrProfile? profile;

  MypageMainViewModel() {
    refresh();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void refresh() {
    _repository.getProfile().then((profile) {
      this.profile = profile;
      notifyListeners();
    });
  }
}
