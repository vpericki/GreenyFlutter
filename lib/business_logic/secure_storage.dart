import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greeny_flutter_app/models/user.dart';

class SecureStorage {
  static SecureStorage _instance = SecureStorage();

  factory SecureStorage() =>
      _instance = SecureStorage._(FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _tokenKey = 'TOKEN';
  static const _userInfoKey = 'USER';

  Future<void> persistUserAndToken(User user) async {
    await _storage.write(key: _tokenKey, value: user.token!.plainTextToken);
    await _storage.write(key: _userInfoKey, value: json.encode(user.toJson()));
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _tokenKey);
    return value != null;
  }

  Future<bool> hasUserInfo() async {
    var value = await _storage.read(key: _userInfoKey);
    return value != null;
  }

  Future<void> deleteToken() async {
    return _storage.delete(key: _tokenKey);
  }

  Future<void> deleteUserInfo() async {
    return _storage.delete(key: _userInfoKey);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<String?> getUserInfo() async {
    return _storage.read(key: _userInfoKey);
  }

  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }
}

var secureStorage = SecureStorage();
