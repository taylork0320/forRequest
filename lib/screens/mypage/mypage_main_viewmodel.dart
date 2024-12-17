import 'package:flutter/cupertino.dart';
import 'package:sasimee/models/posting.dart';
import 'package:sasimee/models/response/auth/get_profile_response.dart';
import 'package:sasimee/repositories/auth_repository.dart';
import 'package:sasimee/repositories/posting_repository.dart';

class MypageMainViewModel with ChangeNotifier {
  late final _authRepository = AuthRepository();
  late final _postingRepository = PostingRepository();
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

  late final applicationDetailsList = Stream.fromFuture(_postingRepository
      .getCompletePostingList()
      .then((value) => value?.posts ?? <Posting>[])).asBroadcastStream();

  late final recruitmentDetailsList = Stream.fromFuture(_postingRepository
      .getUserPostingList()
      .then((value) => value?.posts ?? <Posting>[])).asBroadcastStream();

  MypageMainViewModel() {
    refresh();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void refresh() {
    _authRepository.getProfile().then((profile) {
      this.profile = profile;
      notifyListeners();
    });
  }
}
