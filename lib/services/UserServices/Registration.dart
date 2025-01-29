import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/services/BaseAPI.dart';
import '../../models/UserManagement/userRegistration.dart';

class RegistrationService extends BaseAPI{


  Future<http.Response> register(String firstName, String lastName, String email, String password) async{
    UserRegistration newUser = UserRegistration(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
    );
    var body = jsonEncode(newUser.toJson());

    try{
      http.Response response =
      await http.post(
           Uri.parse(super.registerAPI), headers: super.headers, body: body
      );
      print("Registered Successfully XXXXXXXXXXXXXX");
      return response;
    }catch(e){
      throw Exception("Failed to register user: $e");
    }
  }
}