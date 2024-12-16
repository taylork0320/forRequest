import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  late FlutterSecureStorage _secureStorage;

  SecureStorageService._internal() {
    AndroidOptions androidOptions() =>
        const AndroidOptions(encryptedSharedPreferences: true);
    IOSOptions iosOptions() => const IOSOptions(
        accountName: "jpower-ios-flutter",
        accessibility: KeychainAccessibility.first_unlock);
    _secureStorage = FlutterSecureStorage(
        aOptions: androidOptions(), iOptions: iosOptions());
  }

  FlutterSecureStorage get() {
    return _secureStorage;
  }
}
