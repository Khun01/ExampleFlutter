import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage{
  static const _storage = FlutterSecureStorage();

  static Future<void> saveField(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getField(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteField(String key) async {
    await _storage.delete(key: key);
  }

  static Future<void> saveUserData({
    required String token,
    required int userId,
    required String name,
    required String email,
    required String? profilePicture,
    required String? number,
    required String? address,
  }) async {
    await Future.wait([
      saveField('userToken', token),
      saveField('userId', userId.toString()),
      saveField('userName', name),
      saveField('userEmail', email),
      saveField('userProfilePicture', profilePicture ?? ''),
      saveField('userPhoneNumber', number ?? ''),
      saveField('userAddress', address ?? ''),
    ]);
  }

  static Future<Map<String, String?>> getUserData() async {
    final userData = await Future.wait([
      getField('userToken'),
      getField('userId'),
      getField('userName'),
      getField('userEmail'),
      getField('userProfilePicture'),
      getField('userPhoneNumber'),
      getField('userAddress')
    ]);

    return {
      'token': userData[0],
      'userId': userData[1],
      'name': userData[2],
      'email': userData[3],
      'profilePicture': userData[4] ?? '',
      'userPhoneNumber': userData[5] ?? '',
      'userAddress': userData[6] ?? ''
    };
  }

  static Future<void> deleteUserData() async {
    await Future.wait([
      deleteField('userToken'),
      deleteField('userId'),
      deleteField('userName'),
      deleteField('userEmail'),
      deleteField('userProfilePicture'),
      deleteField('userPhoneNumber'),
      deleteField('userAddress'),
    ]);
  }  
}