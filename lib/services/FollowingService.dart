import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:http/http.dart' as http;

class FollowingService extends BaseAPI{
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> followChef(String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        print("No token available");
        return false;
      }
      final response = await http.post(
        Uri.parse("${super.followChefAPI}/$chefId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        print("Chef followed");
        return true;
      }else{
        print("Error: couldn't follow chef: ${response.statusCode}");
        return false;
      }
    }catch(e){
      print("Error following chef: $e");
      return false;
    }

  }

}