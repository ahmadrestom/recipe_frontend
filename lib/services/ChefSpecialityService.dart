import 'dart:convert';

import 'package:recipe_app/models/chef_speciality.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:http/http.dart' as http;

class ChefSpecialityService extends BaseAPI{

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

}