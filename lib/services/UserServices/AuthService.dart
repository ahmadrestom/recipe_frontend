import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/UserManagement/userAuthentication.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/services/BaseAPI.dart';

import '../../models/UserManagement/userRegistration.dart';
class AuthService extends BaseAPI{
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<http.Response> login(UserAuthentication userAuth) async{
    final response = await http.post(
      Uri.parse(super.authAPI),
      headers: super.headers,
      body: jsonEncode(userAuth.toJson()),
    );
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final token = data['token'];

      await secureStorage.write(key: 'authToken', value: token);
      return response;
    }else{
      throw Exception('Failed to log in: ${response.statusCode} ${response.body}');
    }
  }

  Future<String?> getToken() async{
    String? token = await secureStorage.read(key: 'authToken');
    if(token != null && isTokenExpired(token)){
      await logout();
      throw Exception('Token expired, please log in again');
    }
    return token;
  }

  bool isTokenExpired(String token){
    try{
      DateTime expiryDate = Jwt.getExpiryDate(token)!;
      return expiryDate.isBefore(DateTime.now());
    }catch(e){
      print('Error checking token expiration: $e');
      return true;
    }
  }

  Future<void> logout() async{
    await secureStorage.delete(key: 'authToken');
  }

  Future<http.Response> get(String url) async{
    final token = await getToken();
    if(token == null){
      throw Exception('No valid token available');
    }
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode == 401){
      await logout();
      throw Exception('Unauthorized, please log in again');
    }
    return response;
  }




}