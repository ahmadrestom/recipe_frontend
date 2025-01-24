import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/pages/ViewChefData.dart';

class FollowUser extends StatelessWidget {
   const FollowUser({super.key, required this.name, this.imageUrl, required this.role,required this.id});
  final String name;
  final String? imageUrl;
  final String role;
  final String id;

  @override
  Widget build(BuildContext context){

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: role=='CHEF'? (){
        Navigator.push(context,
            MaterialPageRoute(builder:
                (context)=>ViewChefData(chefId: id,)));
      }
      :null,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.135,
                height: screenWidth * 0.135,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageUrl == null
                        ? const AssetImage("assets/icons/defaultProfile.png") as ImageProvider
                        : NetworkImage(imageUrl!) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 19,
                      offset: const Offset(1, 3),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth*0.05,),
              Text(name),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        role,
                      style: GoogleFonts.albertSans(
                        color: const Color.fromRGBO(66, 66, 66, 0.6)
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight*0.02,),
        ],
      ),
    );
  }
}
