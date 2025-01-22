import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:recipe_app/services/ChefSpecialityService.dart';

class ChefSpecialityProvider extends ChangeNotifier{

  final ChefSpecialityService _chefSpecialityService = ChefSpecialityService();

  String? _token;

  List<ChefSpeciality>? _specialitiesForChef;

  Set<ChefSpeciality>? _specialities;

  Set<ChefSpeciality>? get specialities  => _specialities;

  String? get token => _token;

  List<ChefSpeciality>? get specialitiesForChef => _specialitiesForChef;

  Future<void> fetchAllSpecialities() async{
    try{
      _specialities = {};
      final Set<ChefSpeciality> set = await _chefSpecialityService.getAllSpecialities();
      _specialities = set;
    }catch(e){
      print("Error: provider level: $e");
      throw Exception("Error: provider level: $e");
    }finally{
      notifyListeners();
    }
  }

  Future<void> addSpecialityLink(String chefId, String specialityId) async{
    try{
      final result = await _chefSpecialityService.addChefSpecialities(chefId, specialityId);
      if(!result){
        print("Error: can't add link");
        throw Exception("Error adding link");
      }
    }catch(e){
      print("Error : $e");
      throw Exception("Error::$e");
    }

  }

  Future<void> getSpecialitiesForChef(String chefId)async{
    try{
      _specialitiesForChef = [];
      final List<ChefSpeciality> list = await _chefSpecialityService.getAllSpecialityForChef(chefId);
      _specialitiesForChef = list;
    }catch(e){
      print("Error: $e");
      throw Exception("Error::$e");
    }finally{
      notifyListeners();
    }
  }




}