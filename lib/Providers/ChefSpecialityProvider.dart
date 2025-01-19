import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:recipe_app/services/ChefSpecialityService.dart';

class ChefSpecialityProvider extends ChangeNotifier{

  final ChefSpecialityService chefSpecialityService = ChefSpecialityService();

  Set<ChefSpeciality>? _specialities;

  Set<ChefSpeciality>? get specialities  => _specialities;

  Future<void> fetchAllSpecialities() async{
    try{
      final Set<ChefSpeciality> set = await chefSpecialityService.getAllSpecialities();
      _specialities = set;
    }catch(e){
      print("Error: provider level: $e");
      throw Exception("Error: provider level: $e");
    }finally{
      notifyListeners();
    }
  }




}