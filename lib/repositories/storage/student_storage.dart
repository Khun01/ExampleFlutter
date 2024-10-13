import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StudentStorage {
  static const _storage = FlutterSecureStorage();
  static const _prefix = 'student_';

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
    String? studToken,
    String? userId,
    String? fullName,

    String? college,
    String? course,
    String? department,
    String? semester,
    String? learningModality,

    String? fatherName,
    String? fatherContactNumber,
    String? motherName,
    String? motherContactNumber,

    String? currentAddress,
    String? currentProvince,
    String? currentCountry,
    String? currentCity,

    String? permanentAddress,
    String? permanentProvince,
    String? permanentCountry,
    String? permanentCity,

    String? emergencyPersonName,
    String? emergencyAddress,
    String? relation,
    String? emergencyContactNumber,

    String? activeDuties,
    String? completedDuties,
    String? totalDuty,
    String? dutyHoursRemaining,

  }) async {
    await Future.wait([
      saveField('userId', id ?? ""),
      saveField('firstName', firstName ?? ""),
      saveField('lastName', lastName ?? ""),
      saveField('birthday', birthday ?? ""),
      saveField('contactNumber', contactNumber ?? ""),
      saveField('idNumber', idNumber ?? ""),
      saveField('profileImg', profileImg ?? ''),      
      saveField('studToken', studToken ?? ''),
      saveField('user_id', userId ?? ""),
      saveField('name', fullName ?? ""),

      saveField('college', college ?? ''),
      saveField('course', course ?? ''),
      saveField('department', department ?? ''),
      saveField('semester', semester ?? ''),
      saveField('learningModality', learningModality ?? ''),

      saveField('fatherName', fatherName ?? ''),
      saveField('fatherContactNumber', fatherContactNumber ?? ''),
      saveField('motherName', motherName ?? ''),
      saveField('motherContactNumber', motherContactNumber ?? ''),

      saveField('currentAddress', currentAddress ?? ''),
      saveField('currentProvince', currentProvince ?? ''),
      saveField('currentCountry', currentCountry ?? ''),
      saveField('currentCity', currentCity ?? ''),

      saveField('permanentAddress', permanentAddress ?? ''),
      saveField('permanentProvince', permanentProvince ?? ''),
      saveField('permanentCountry', permanentCountry ?? ''),
      saveField('permanentCity', permanentCity ?? ''),

      saveField('emergencyPersonName', emergencyPersonName ?? ''),
      saveField('emergencyAddress', emergencyAddress ?? ''),
      saveField('relation', relation ?? ''),
      saveField('emergencyContactNumber', emergencyContactNumber ?? ''),

      saveField('activeDuties', activeDuties ?? ''),
      saveField('completedDuties', completedDuties ?? ''),
      saveField('totalDuty', totalDuty ?? ''),
      saveField('dutyHoursRemaining', dutyHoursRemaining ?? '')

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
      getField('studToken'),
      getField('user_id'),
      getField('name'),

      getField('college'),
      getField('course'),
      getField('department'),
      getField('semester'),
      getField('learningModality'),

      getField('fatherName'),
      getField('fatherContactNumber'),
      getField('motherName'),
      getField('motherContactNumber'),

      getField('currentAddress'),
      getField('currentProvince'),
      getField('currentCountry'),
      getField('currentCity'),

      getField('permanentAddress'),
      getField('permanentProvince'),
      getField('permanentCountry'),
      getField('permanentCity'),

      getField('emergencyPersonName'),
      getField('emergencyAddress'),
      getField('relation'),
      getField('emergencyContactNumber'),

      getField('activeDuties'),
      getField('completedDuties'),
      getField('totalDuty'),
      getField('dutyHoursRemaining')
    ]);

    final data = {
      'id': userData[0],
      'firstName': userData[1],
      'lastName': userData[2],
      'birthday': userData[3],
      'contactNumber': userData[4],
      'idNumber': userData[5],
      'profileImg': userData[6] ?? '',
      'studToken': userData[7],
      'user_id': userData[8],
      'name': userData[9],

      'college': userData[10],
      'course': userData[11],
      'department': userData[12],
      'semester': userData[13],
      'learningModality': userData[14],

      'fatherName': userData[15],
      'fatherContactNumber': userData[16],
      'motherName': userData[17],
      'motherContactNumber': userData[18],

      'currentAddress': userData[19],
      'currentProvince': userData[20],
      'currentCountry': userData[21],
      'currentCity': userData[22],

      'permanentAddress': userData[23],
      'permanentProvince': userData[24],
      'permanentCountry': userData[25],
      'permanentCity': userData[26],

      'emergencyPersonName': userData[27],
      'emergencyAddress': userData[28],
      'relation': userData[29],
      'emergencyContactNumber': userData[30],

      'activeDuties' : userData[31],
      'completedDuties': userData[32],
      'totalDuty': userData[33],
      'dutyHoursRemaining': userData[34],
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
      deleteField('studToken'),
      deleteField('user_id'),
      deleteField('name'),

      deleteField('college'),
      deleteField('course'),
      deleteField('department'),
      deleteField('semester'),
      deleteField('learningModality'),

      deleteField('fatherName'),
      deleteField('fatherContactNumber'),
      deleteField('motherName'),
      deleteField('motherContactNumber'),

      deleteField('currentAddress'),
      deleteField('currentProvince'),
      deleteField('currentCountry'),
      deleteField('currentCity'),

      deleteField('permanentAddress'),
      deleteField('permanentProvince'),
      deleteField('permanentCountry'),
      deleteField('permanentCity'),

      deleteField('emergencyPersonName'),
      deleteField('emergencyAddress'),
      deleteField('relation'),
      deleteField('emergencyContactNumber'),

      deleteField('activeDuties'),
      deleteField('completedDuties'),
      deleteField('totalDuty'),
      deleteField('dutyHoursRemaining')
    ]);
  }
}
