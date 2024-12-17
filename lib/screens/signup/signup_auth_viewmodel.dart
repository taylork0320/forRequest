import 'dart:async';

import 'package:flutter/cupertino.dart';

class SignupAuthViewModel with ChangeNotifier {
  final TextEditingController _authenticationCodeController =
  TextEditingController();

  get authenticationCodeController => _authenticationCodeController;

  final FocusNode _authenticationCodeFocusNode = FocusNode();

  get authenticationCodeFocusNode => _authenticationCodeFocusNode;

  bool _isButtonEnabled = false;

  bool get isButtonEnabled => _isButtonEnabled;

  DateTime _expiredTime = DateTime.now().add(const Duration(minutes: 3));

  late final Stream<Duration> _timer =
  Stream.periodic(const Duration(milliseconds: 200), (_) {
    return _expiredTime.difference(DateTime.now());
  }).asBroadcastStream();

  get timer => _timer;

  late final StreamSubscription<Duration> _subscription;
  Duration? _duration;

  SignupAuthViewModel() {
    _authenticationCodeController.addListener(_validateInputs);
    _subscription = timer.listen((duration) {
      _duration = duration;
      _validateInputs();
    });
  }

  void _validateInputs() {
    final code = _authenticationCodeController.text.trim();
    final seconds = _duration?.inSeconds ?? -1;

    _isButtonEnabled = code.length == 6 && seconds > 0;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _authenticationCodeController.dispose();
    _authenticationCodeFocusNode.dispose();

    _subscription.cancel();
  }

  Future<void> requestOtp() async {
    _authenticationCodeController.clear();
    _expiredTime = DateTime.now().add(const Duration(minutes: 3));
  }
}