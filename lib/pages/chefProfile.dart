import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/RecipeProvider.dart';
import 'package:recipe_app/customerWidgets/RecipeForProfile.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/pages/ViewChefSpecialities.dart';
import 'package:recipe_app/pages/recipeInformation.dart';
import '../Providers/FollowingProvider.dart';
import '../Providers/UserProvider.dart';
import '../models/FollowerStats.dart';
import 'package:image_cropper/image_cropper.dart';
import 'landing.dart';
import 'package:path/path.dart' as path;


class ChefProfile extends StatefulWidget {
  const ChefProfile({super.key, required this.id});
  final String id;

  @override
  State<ChefProfile> createState() => _ChefProfileState();
}

class _ChefProfileState extends State<ChefProfile> {

  Map<String, dynamic>? chefDetails;
  List<RecipeForProfile>? recipes;
  int nbRecipes = 0;
  FollowerStats? followerStats;
  File? _image;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
      final followProvider = Provider.of<FollowingProvider>(context, listen: false);
      await followProvider.getStats(widget.id);
      await userProvider.getChefInfo(widget.id);
      setState(() {
        if(followProvider.followerStats != null){
          followerStats = followProvider.followerStats;
        }
        chefDetails = userProvider.chefDetails;
        chefDetails?['image_url'];
      });
      await recipeProvider.fetchRecipesForProfile(widget.id);
      setState(() {
        print("XXXXX ${widget.id}");
        recipes = recipeProvider.recipesForProfile;
        if(recipes!.isNotEmpty){
          nbRecipes = recipes!.length;
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(chefDetails == null){
      return const Center(child: CircularProgressIndicator());
    }
    // if(recipes!.isNotEmpty && nbRecipes == 0){
    //   return const Center(child: CircularProgressIndicator());
    // }

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth*0.03, screenHeight*0.03, screenWidth*0.03, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: screenWidth*0.1,),
                  const Text(
                      "Profile",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Color.fromRGBO(18, 18, 18, 1),
                    ),
                  ),
                  PopupMenuButton(
                      elevation: 10,
                      offset: const Offset(0,40),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 27,
                      ),
                      onSelected: (String value){

                      },
                      itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: const Row(
                            children: [
                              Icon(Icons.star, size: 20,),
                              SizedBox(width: 30,),
                              Text(
                                "Specialities",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(18, 18, 18, 1),

                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewChefSpecialities(chefId: widget.id, name: "${chefDetails?['firstName'].toString()}",)
                              ),
                            );
                          },
                        ),
                        PopupMenuItem(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: const Row(
                            children: [
                              Icon(Icons.logout, size: 20),
                              SizedBox(width: 30),
                              Text(
                                "Sign out",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Color.fromRGBO(18, 18, 18, 1),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Future.delayed(
                              const Duration(milliseconds: 100), // Delay to ensure menu dismisses
                                  () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      title: const Text(
                                        "Log Out",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color.fromRGBO(18, 18, 18, 1),
                                        ),
                                      ),
                                      content: const Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color.fromRGBO(100, 100, 100, 1),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color.fromRGBO(100, 100, 100, 1),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final userProvider = Provider.of<UserProvider>(context, listen: false);
                                            await userProvider.logout();
                                            if(mounted){
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const LandingPage(),
                                                ),
                                                    (route) => false,
                                              );
                                            }


                                          },
                                          child: const Text(
                                            "Log Out",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                      ]
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.02,),
              Consumer<UserProvider>(
                  builder: (context, userProvider, child){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            key: UniqueKey(),
                            radius: screenWidth *0.13,
                            backgroundImage: userProvider.imageUrl!.isEmpty
                                ? const AssetImage('assets/images/img.png') as ImageProvider
                                : NetworkImage(userProvider.imageUrl!),
                          ),
                          onTap: (){
                            _showChangeProfileDialog();
                          },
                        ),
                        Container(width: screenWidth*0.07,),
                        Column(
                          children: [
                            Text(
                              "Recipes",
                              style: TextStyle(
                                  color: const Color.fromRGBO(169, 169, 169, 1),
                                  fontSize: screenWidth * 0.033,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              nbRecipes.toString(),
                              style: TextStyle(
                                  color: const Color.fromRGBO(18, 18, 18, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth*0.045,
                                  fontFamily: 'Poppins'
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth*0.02,),
                        Column(
                          children: [
                            Text(
                              "Followers",
                              style: TextStyle(
                                  color: const Color.fromRGBO(169, 169, 169, 1),
                                  fontSize: screenWidth * 0.033,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              followerStats != null ? followerStats!.followerCount.toString() : '0',
                              style: TextStyle(
                                  color: const Color.fromRGBO(18, 18, 18, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth*0.045,
                                  fontFamily: 'Poppins'
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: screenWidth*0.02,),
                        Column(
                          children: [
                            Text(
                              "Following",
                              style: TextStyle(
                                  color: const Color.fromRGBO(169, 169, 169, 1),
                                  fontSize: screenWidth * 0.033,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              followerStats !=null ? followerStats!.followingCount.toString():'0',
                              style: TextStyle(
                                  color: const Color.fromRGBO(18, 18, 18, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth*0.045,
                                  fontFamily: 'Poppins'
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
              ),
              SizedBox(height: screenHeight*0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${chefDetails?['firstName']} ${chefDetails?['lastName']}",
                    style: const TextStyle(
                      color: Color.fromRGBO(18, 18, 18, 1),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                  const Text(
                      "Chef",
                    style: TextStyle(
                      color: Color.fromRGBO(169, 169, 169, 1),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    chefDetails?['bio'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color.fromRGBO(80,80, 80, 1),
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Years of experience: ",
                        style: TextStyle(
                          color: Color.fromRGBO(169, 169, 169, 1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.033,
                        ),
                      ),
                      Text(
                        chefDetails!['years_experience'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color.fromRGBO(80,80,80,1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color.fromRGBO(18, 149, 117, 1),
                      ),
                      Text(
                        chefDetails?['location'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: screenHeight *0.04,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(18, 149, 117, 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        "Recipes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromRGBO(255,255,255,1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth*0.04
                        ),

                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight*0.03,),

              Expanded(
                child: (recipes==null || recipes!.isEmpty)?
                    const Center(child: Text("No Recipes"),)
                :ListView.builder(
                  itemCount: recipes!.length,
                  itemBuilder: (context, index){
                    bool isFirst = index == 0;
                    bool isLast = index == recipes!.length - 1;
                    EdgeInsets itemMargin = EdgeInsets.only(
                       top: isFirst ? 2 : 10, bottom: isLast ? 0 : 10);
                    return GestureDetector(
                      onTap: () {
                        final ide = recipes![index].recipeId;
                        print("Recipe ID: $ide");
                        final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
                        recipeProvider.fetchRecipeById(ide).then((_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeInformation(
                                recipe: recipeProvider.recipeByID!,
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        margin: itemMargin,
                        child: Recipeforprofile(
                          recipe: recipes![index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
      )
    );
  }
  void _showChangeProfileDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Change Profile Picture"),
              onTap: () {
                _pickImage();
                Navigator.pop(context);
              },
            ),
            Provider.of<UserProvider>(context,listen: false).imageUrl!.isNotEmpty?ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Remove Profile Picture"),
              onTap: () {
                Provider.of<UserProvider>(context, listen:false).updateProfileImage("");
                setState(() {
                  _profileImageUrl = null;
                });
                Navigator.pop(context);
              },
            ):Container(height: 0.00001,)
          ],
        );
      },
    );
  }
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }
  void _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [
        AndroidUiSettings(
            cropStyle: CropStyle.circle,
            statusBarColor: const Color.fromRGBO(18, 149, 117, 1),
            hideBottomControls: true,
            showCropGrid: false,
            toolbarTitle: 'Edit Profile Picture',
            toolbarColor: const Color.fromRGBO(18, 149, 117, 1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,

        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],

    );
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
        _profileImageUrl = _image?.path;
      });
      if(mounted){
        final userProvider = Provider.of<UserProvider>(context,listen: false);
        final url = await userProvider.uploadImage(_image!, 'ProfilePicture', path.basename(_image!.path),);
        if(url !=null){
          userProvider.updateProfileImage(url);
          await userProvider.updateImage(widget.id, url);
          print("Profile picture updated successfully");
        }else{
          print("Error: Image not uploaded");
        }
      }


    } else {
      print("Image cropping cancelled");
    }
  }
}