bool isValidEmail(String email) {
  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regExp = RegExp(emailPattern);
  return regExp.hasMatch(email);
}

bool isValidPassword(String password) {
  // 정규식을 사용해 영어, 숫자, 특수문자만 포함되었는지 확인
  final bool isValidCharacters = RegExp(r'^[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]+$').hasMatch(password);
  // 길이가 6자 이상인지 확인
  final bool isLengthValid = password.length >= 6;
  // 두 조건 모두 충족해야 유효
  return isValidCharacters && isLengthValid;
}
