import 'package:flutter/cupertino.dart';
import 'package:recipe_app/services/FollowingService.dart';

class FollowingProvider extends ChangeNotifier{

  final FollowingService _followingService = FollowingService();


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





}