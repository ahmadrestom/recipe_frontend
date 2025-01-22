import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:http/http.dart' as http;

class ChefSpecialityService extends BaseAPI{

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<Set<ChefSpeciality>> getAllSpecialities() async{
    try{
      final response = await http.get(
        Uri.parse(super.getSpecialitiesAPI),
        headers: super.headers
      );

      if(response.statusCode == 200){
        final List<dynamic> jsonData = jsonDecode(response.body);
        final specialities = jsonData.map((item) {
          return ChefSpeciality.fromJson(item as Map<String, dynamic>);
        }).toSet();
        return specialities;
      }else{
        print("No data returned: ${response.statusCode}");
        throw Exception("Failed to load specialities: HTTP ${response.statusCode}");
      }
    }catch(e){
      print("Error fetching specialities: $e");
      throw Exception("An error occurred: $e");
    }
  }

  Future<bool> addChefSpecialities(String chefId, String specialityId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        return false;
      }
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        Uri.parse("${super.addSpecialityLinkAPI}/$chefId/$specialityId"),
        headers: headers
      );
      if(response.statusCode == 201){
        print("DONE!: ${response.statusCode}");
        return true;
      }else{
        print("Error with code: ${response.statusCode}");
        return false;
      }
    }catch(e){
      print("Error: $e");
      return false;
    }
  }

  Future<List<ChefSpeciality>> getAllSpecialityForChef(String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        print("No token available");
        throw Exception("No token available");        
      }
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      
      final response = await http.get(
        Uri.parse("${super.getSpecialitiesForChef}/$chefId"),
        headers: headers
      );
      if(response.statusCode == 200){
        print("Success: ${response.statusCode}");
        List<dynamic> data = jsonDecode(response.body);
        List<ChefSpeciality> list = data.map<ChefSpeciality>((item) => ChefSpeciality.fromJson(item)).toList();
        return list;
      }else if(response.statusCode == 204){
        return [];
      }
      else{
        print("Error: ${response.statusCode}");
        throw Exception("Error :: ${response.statusCode}");
      }
    }catch(e){
      print("Error: $e");
      throw Exception("Error::$e");
    }
  }
}