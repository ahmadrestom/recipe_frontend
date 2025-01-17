import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/customerWidgets/UpgradeToChef.dart';

class Upgradetochef extends StatefulWidget {

  final String? email;

  const Upgradetochef({super.key, this.email});

  @override
  State<Upgradetochef> createState() => _UpgradetochefState();
}
class _UpgradetochefState extends State<Upgradetochef> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight*0.03, horizontal: screenWidth*0.03),
        child: Column(
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                size: 27,
                color: Color.fromRGBO(41, 45, 50, 1),
              ),
            ),
            ]
          ),
            SizedBox(height: screenHeight*0.02,),
            UserProfilePage(email: widget.email),
          ],
        ),
      ),

    );
  }
}
