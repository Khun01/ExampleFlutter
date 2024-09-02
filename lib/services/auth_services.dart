import 'dart:convert';
import 'dart:developer';
import 'package:help_isko/services/global.dart';
import 'package:help_isko/services/storage.dart';
import 'package:http/http.dart' as http;

class AuthServices{
  final String apiUrl;

  AuthServices({required this.apiUrl});

  Future<Map<String, dynamic>> loginProf(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-prof'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('User data: $responseData');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<int> logout() async{
    final userData = await Storage.getProfData();
    String? token = userData['token'];
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      } 
    ); 
    // final Map<String, dynamic> responseData = jsonDecode(response.body);
    return response.statusCode;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async{
    final response = await http.post(
      Uri.parse('$baseUrl/forgot'),
      headers: {'Content-Type': 'application/json'},
       body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('The response is: $response');
    log('The response is: $responseData');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  

  // static Future<List<Products>> fetchProducts() async{
  //   String? token = await SharedPreferencesUtil.getToken();
  //   var url = Uri.parse('$baseUrl/api/products');
  //   final response = await http.get(
  //     url, 
  //     headers: {
  //       ...headers,
  //       'Authorization': 'Bearer $token'
  //     }
  //   );
  //   List<dynamic> data = jsonDecode(response.body);
  //   List<Products> productList = [];

  //   for(var item in data){
  //     Products products = Products.fromJson(item);
  //     productList.add(products);
  //   }
  //   return productList;
  // }
}