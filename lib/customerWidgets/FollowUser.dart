import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/pages/ViewChefData.dart';

class FollowUser extends StatelessWidget {
  const FollowUser({
    super.key,
    required this.name,
    this.imageUrl,
    required this.role,
    required this.id,
  });

  final String name;
  final String? imageUrl;
  final String role;
  final String id;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: role == 'CHEF'
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewChefData(chefId: id),
          ),
        );
      }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.012,
          horizontal: screenWidth * 0.04,
        ),
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
        decoration: BoxDecoration(
          color: Color.fromRGBO(240, 240, 240, 0.4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.07,
              backgroundImage: imageUrl == null
                  ? const AssetImage("assets/icons/defaultProfile.png")
              as ImageProvider
                  : NetworkImage(imageUrl!),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    role,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.038,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (role == 'CHEF')
              Icon(
                Icons.arrow_forward_ios,
                size: screenWidth * 0.045,
                color: Colors.grey[500],
              ),
          ],
        ),
      ),
    );
  }
}
