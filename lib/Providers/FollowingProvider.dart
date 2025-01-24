import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/FollowerStats.dart';
import 'package:recipe_app/services/FollowingService.dart';
import '../models/Follower.dart';

class FollowingProvider extends ChangeNotifier{

  final FollowingService _followingService = FollowingService();

  Set<Follower>? _followers;

  FollowerStats? _followerStats;

  Set<Follower>? _followings;

  Set<Follower>? get followers => _followers;

  Set<Follower>? get followings => _followings;

  FollowerStats? get followerStats => _followerStats;

  void _resetData() {
    _followers = {}; // Clear followers
    _followerStats = null; // Clear stats
    notifyListeners();
  }

  Future<void> getAllFollowers(String chefId) async{
    try{
      _resetData();
      final Set<Follower> set = await _followingService.getAllFollower(chefId);
      _followers = set;
    }catch(e){
      print("Error fetching followers");
      throw Exception("Error fetching followers");
    }finally{
      notifyListeners();
    }
  }

  Future<void> getAllFollowings(String userId) async{
    try{
      _resetData();
      final Set<Follower> set = await _followingService.getAllFollowings(userId);
      _followings = set;
    }catch(e){
      print("Error fetching followers");
      throw Exception("Error fetching followers");
    }finally{
      notifyListeners();
    }
  }

  Future<void> followChef(String chefId) async{
    try{
      final result = await _followingService.followChef(chefId);
      if(result == false){
        print("ERROR");
        throw Exception("Error::following chef");
      }
    }catch(e){
      print("Error provider :: $e");
      throw Exception("Error following chef :: $e");
    }finally{
      notifyListeners();
    }
  }

  Future<void> unfollowChef(String chefId) async{
    try{
      final result = await _followingService.unfollowChef(chefId);
      if(result == false){
        print("ERROR");
        throw Exception("Error::following chef");
      }
    }catch(e){
      print("Error provider :: $e");
      throw Exception("Error following chef :: $e");
    }finally{
      notifyListeners();
    }
  }

  Future<void> getStats(String chefId) async{
    try{
      _resetData();
      final FollowerStats stats = await _followingService.getFollowerStats(chefId);
      _followerStats = stats;
    }catch(e){
      throw Exception("Error: provider: $e");
    }finally{
      notifyListeners();
    }
  }

  Future<bool> isFollowing(String userId, String chefId) async{
    try{
      final res = await _followingService.isFollowing(userId,chefId);
      return res;
    }catch(e){
      throw Exception("Error::$e");
    }
  }
}