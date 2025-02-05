import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:recipe_app/pages/UserProfilePage.dart';
import 'ChooseSpecialities.dart';
import 'chefProfile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{

  bool? chef;
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? name;
  List<ChefSpeciality>? specialities;

  @override
  void initState() {
    super.initState();
    chef = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProfile();
    });
  }

  Future<void> _initializeProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final specialityProvider = Provider.of<ChefSpecialityProvider>(context, listen: false);

    id = userProvider.userDetails?['id'];
    email = userProvider.userDetails?['email'];
    firstName = userProvider.userDetails?['firstName'];
    lastName = userProvider.userDetails?['lastName'];

    if (userProvider.userDetails?['role'] == "USER") {
      setState(() {
        chef = false;
        name = "$firstName $lastName";
      });
    } else {
      await specialityProvider.getSpecialitiesForChef(id!);
      final fetchedSpecialities = specialityProvider.specialitiesForChef;

      // Navigate if specialities are empty
      if (fetchedSpecialities == null || fetchedSpecialities.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseSpecialities(chefId: id!),
          ),
        );
      } else {
        setState(() {
          chef = true;
          specialities = fetchedSpecialities;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    if(chef == null){
      return Center(child: Lottie.asset(
          'assets/loader.json'
      ),);
    }
    if(chef! && specialities!.isNotEmpty){
      return ChefProfile(id: id!);
    }
    else{
      return UserProfile(id: id, email: email, name: name,);
    }
  }
}