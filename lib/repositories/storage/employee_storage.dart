import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmployeeStorage {
  static const _storage = FlutterSecureStorage();
  static const _prefix = 'employee_';

  static Future<void> saveField(String key, String value) async {
    await _storage.write(key: '$_prefix$key', value: value);
  }

  static Future<String?> getField(String key) async {
    return await _storage.read(key: '$_prefix$key');
  }

  static Future<void> deleteField(String key) async {
    await _storage.delete(key: '$_prefix$key');
  }

  static Future<void> saveData({
    String? id,
    String? firstName,
    String? lastName,
    String? birthday,
    String? contactNumber,
    String? idNumber,
    String? profileImg,
    String? employeeToken,
    String? userId,
    String? fullName,

  }) async {
    await Future.wait([
      saveField('userId', id ?? ""),
      saveField('firstName', firstName ?? ""),
      saveField('lastName', lastName ?? ""),
      saveField('birthday', birthday ?? ""),
      saveField('contactNumber', contactNumber ?? ""),
      saveField('idNumber', idNumber ?? ""),
      saveField('profileImg', profileImg ?? ''),
      saveField('employeeToken', employeeToken ?? ""),
      saveField('user_id', userId ?? ""),
      saveField('name', fullName ?? ""),
    ]);
  }

  static Future<Map<String, String?>> getData() async {
    final userData = await Future.wait([
      getField('id'),
      getField('firstName'),
      getField('lastName'),
      getField('birthday'),
      getField('contactNumber'),
      getField('idNumber'),
      getField('profileImg'),
      getField('employeeToken'),
      getField('user_id'),
      getField('name'),
    ]);

    final data = {
      'id': userData[0],
      'firstName': userData[1],
      'lastName': userData[2],
      'birthday': userData[3],
      'contactNumber': userData[4],
      'idNumber': userData[5],
      'profileImg': userData[6] ?? '',
      'employeeToken': userData[7],
      'user_id': userData[8],
      'name': userData[9],

    };
    return data;
  }

  static Future<void> deleteData() async {
    await Future.wait([
      deleteField('id'),
      deleteField('firstName'),
      deleteField('lastName'),
      deleteField('birthday'),
      deleteField('contactNumber'),
      deleteField('idNumber'),
      deleteField('profileImg'),
      deleteField('employeeToken'),
      deleteField('user_id'),
      deleteField('name'),
    ]);
  }
}
