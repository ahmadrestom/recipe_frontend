import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/landing.dart';

import 'chefProfile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{

  bool? chef;
  String? id;

  @override
  void initState() {
    super.initState();
    chef = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      id = userProvider.userDetails?['id'];
      if (userProvider.userDetails?['role'] == "USER") {
        setState(() {
          chef = false;
        });
      } else {
        setState(() {
          chef = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context){
    if(chef == null){
      return const Center(child: CircularProgressIndicator(),);
    }
    if(chef!){
      return ChefProfile(id: id);
    }else{
      return const LandingPage();
    }
  }
}
