import 'dart:convert';

import 'package:help_isko/models/student/requested_duties.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class RequestedDutiesService {
  Future<List<RequestedDuties>> getRequestedDuties() async {
    try {
      final Map<String, dynamic> jsonData = await StudentStorage.getData();
      final String token = jsonData['studToken'];
      final response = await get(
          Uri.parse('$baseUrl/students/duties/requested'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final List<dynamic> listJson = jsonDecode(response.body);
        final requestedDuties =
            listJson.map((e) => RequestedDuties.fromMap(e)).toList();
        return requestedDuties;
      } else {
        throw Exception('Cant Retrieve Requested Duties');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
  // Future<List<RequestedDuties>> getRequestedDuties() async {
  //   try {
  //     final Map<String, dynamic> jsonData = await StudentStorage.getData();
  //     final String token = jsonData['studToken'];
  //     final response = await get(
  //       Uri.parse('$baseUrl/students/duties/requested'),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );

  //     if (response.statusCode == 200) {
  //       final dynamic decodedJson = jsonDecode(response.body);
  //       if (decodedJson is Map<String, dynamic>) {
  //         final List<dynamic> listJson = decodedJson.values.toList();
  //         final requestedDuties =
  //             listJson.map((e) => RequestedDuties.fromMap(e)).toList();
  //         return requestedDuties;
  //       } else if (decodedJson is List && decodedJson.isEmpty) {
  //         return [];
  //       } else {
  //         throw Exception('Unexpected response format');
  //       }
  //     } else {
  //       throw Exception('Cannot Retrieve Requested Duties');
  //     }
  //   } catch (e) {
  //     throw Exception('$e');
  //   }
  // }

  Future<bool> cancelRequestedDuties({required int id}) async {
    try {
      final Map<String, dynamic> jsonData = await StudentStorage.getData();
      final String token = jsonData['studToken'];

      final response = await delete(
          Uri.parse('$baseUrl/students/duties/$id/cancel'),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json'
          });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Duty Failed to cancel ${response.body} $baseUrl/students/duties/$id/cancel');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
