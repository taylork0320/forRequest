import 'package:flutter/cupertino.dart';

class MypageMainViewModel with ChangeNotifier {
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

  MypageMainViewModel();

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}