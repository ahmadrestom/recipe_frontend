import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/pages/UserProfilePage.dart';
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

  @override
  void initState() {
    super.initState();
    chef = null;
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
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
      print(email);
      return Userprofile(id: id, email: email, name: name,);
    }
  }
}
