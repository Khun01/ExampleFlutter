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

  static Future<void> saveEmployeeData({
    required String id,
    required String firstName,
    required String lastName,
    required String birthday,
    required String contactNumber,
    required String employeeNumber,
    required String? profileImg,
    required String token,
    required String userId,
    required String fullName,
  }) async {
    await Future.wait([
      saveField('userId', id),
      saveField('firstName', firstName),
      saveField('lastName', lastName),
      saveField('birthday', birthday),
      saveField('contactNumber', contactNumber),
      saveField('employeeNumber', employeeNumber),
      saveField('profileImg', profileImg ?? ''),
      saveField('token', token),
      saveField('user_id', userId),
      saveField('name', fullName)
    ]);
  }

  static Future<Map<String, String?>> getData() async {
    final userData = await Future.wait([
      getField('id'),
      getField('firstName'),
      getField('lastName'),
      getField('birthday'),
      getField('contactNumber'),
      getField('employeeNumber'),
      getField('profileImg'),
      getField('token'),
      getField('user_id'),
      getField('name')
    ]);

    final data = {
      'id': userData[0],
      'firstName': userData[1],
      'lastName': userData[2],
      'birthday': userData[3],
      'contactNumber': userData[4],
      'employeeNumber': userData[5],
      'profileImg': userData[6] ?? '',
      'token': userData[7],
      'user_id': userData[8],
      'name': userData[9]
    };
    return data;
  }

  static Future<void> deleteEmployeeData() async {
    await Future.wait([
      deleteField('id'),
      deleteField('firstName'),
      deleteField('lastName'),
      deleteField('birthday'),
      deleteField('contactNumber'),
      deleteField('employeeNumber'),
      deleteField('profileImg'),
      deleteField('token'),
      deleteField('user_id'),
      deleteField('name')
    ]);
  }  
}