import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_app/services/BaseAPI.dart';
import 'package:http/http.dart' as http;
import '../models/Follower.dart';
import '../models/FollowerStats.dart';

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
        print("BODY: ${response.body}");
        return false;
      }
    }catch(e){
      print("Error following chef: $e");
      return false;
    }

  }

  Future<Set<Follower>> getAllFollower(String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }

      final response = await http.get(
        Uri.parse("${super.getAllFollowersAPI}/$chefId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        print("Data: ${response.body}");
        print("Code: ${response.statusCode}");

        Set<Follower> followers = data
            .map<Follower>((json) => Follower.fromJson(json))
            .toSet();
        return followers;
      }else{
        print("No data returned");
        return {};

      }
    }catch(e){
      print("Error getting follower: $e");
      throw Exception("Error getting followers::$e");
    }

  }

  Future<FollowerStats> getFollowerStats(String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }
      final response = await http.get(
        Uri.parse("${super.getFollowStatsAPI}/$chefId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        final Map<String, dynamic> data = jsonDecode(response.body);
        return FollowerStats.fromJson(data);
      }else{
        print("Error getting follow stats with code: ${response.statusCode}");
        throw Exception("Error getting follow stats with code: ${response.statusCode}");
      }
    }catch(e){
      print("Error getting follow stats");
      throw Exception("Error getting follow stats");
    }

  }

  Future<bool> isFollowing(String userId, String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("Token not available");
      }
      final response = await http.get(
        Uri.parse("${super.isFollowingAPI}/$userId/$chefId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200) {
        print("XX ${response.statusCode}");
        print("XX ${response.body}");
        return response.body == 'true';
      } else {
        return false;
      }
    }catch(e){
      throw Exception("Error checking if user is following chef: $e");
    }
  }

  Future<bool> unfollowChef(String chefId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        print("No token available");
        return false;
      }
      final response = await http.delete(
        Uri.parse("${super.unfollowChefAPI}/$chefId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode == 200){
        print("Chef unFollowed");
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

  Future<Set<Follower>> getAllFollowings(String userId) async{
    try{
      final token = await secureStorage.read(key: 'authToken');
      if(token == null){
        throw Exception("No token available");
      }

      final response = await http.get(
        Uri.parse("${super.getAllFollowingsAPI}/$userId"),
        headers : {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        print("Data: ${response.body}");
        print("Code: ${response.statusCode}");

        Set<Follower> followings = data
            .map<Follower>((json) => Follower.fromJson(json))
            .toSet();
        return followings;
      }else{
        print("No data returned");
        return {};

      }
    }catch(e){
      print("Error getting follower: $e");
      throw Exception("Error getting followers::$e");
    }

  }

}