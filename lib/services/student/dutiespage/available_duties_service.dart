import 'dart:convert';

import 'package:help_isko/models/student/available_duty.dart';
import 'package:help_isko/repositories/global.dart';
import 'package:help_isko/repositories/storage/student_storage.dart';
import 'package:http/http.dart';

class AvailableDutiesService {
  Future<List<AvailableDuty>> getAvailableDuties() async {
    try {
      final studentMap = await StudentStorage.getData();
      final token = studentMap['studToken'];

      final response =
          await get(Uri.parse('$baseUrl/students/duties/available'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<AvailableDuty> availableDuties =
            jsonList.map((e) => AvailableDuty.fromMap(e)).toList();
        return availableDuties;
      } else {
        throw Exception('Cannot retrieve available duties');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<bool> acceptDuty(int id) async {
    try {
      final studentMap = await StudentStorage.getData();
      final token = studentMap['studToken'];
      final response = await post(
          Uri.parse('$baseUrl/students/duties/$id/request'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 201) {
        return true;
      } else if(response.statusCode == 400){
         throw Exception('You have already requested this duty or it has been processed.');
      }
      else {
        throw Exception('Can\'t accept duty');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
