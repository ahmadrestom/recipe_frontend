import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/pages/savedRecipes.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/pages/upgradeToChef.dart';
import '../Providers/FollowingProvider.dart';
import '../Providers/UserProvider.dart';
import '../models/FollowerStats.dart';
import 'Followers.dart';
import 'landing.dart';
import 'package:path/path.dart' as path;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, this.id, this.email, this.name});
  final String? id;
  final String? email;
  final String? name;

  @override
  State<UserProfile> createState() => _UserprofileState();
}

class _UserprofileState extends State<UserProfile> {

  int favoritesNumber = 0;
  bool isLoading = true;
  FollowerStats? followerStats;
  File? _image;
  String? _profileImageUrl;

  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final followProvider = Provider.of<FollowingProvider>(context, listen: false);
      await followProvider.getStats(widget.id!);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchFavoriteRecipes();
      if(userProvider.userFavorites != null && userProvider.userFavorites!.isNotEmpty && followProvider.followerStats!=null) {
        setState((){
          isLoading = false;
          favoritesNumber = userProvider.userFavorites!.length;
          followerStats = followProvider.followerStats;
        });
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, userProvider, child){
                            return Row(
                              children: [
                                GestureDetector(
                                  child: CircleAvatar(
                                    key: UniqueKey(),
                                    radius: screenWidth *0.13,
                                    backgroundImage: userProvider.userDetails?['imageUrl'] == null
                                        ? const AssetImage('assets/images/img.png') as ImageProvider
                                        : NetworkImage(userProvider.userDetails?['imageUrl']),
                                  ),
                                  onTap: (){
                                    _showChangeProfileDialog();
                                  },
                                  onLongPress: (){
                                    _showFullSizeImageDialog(context);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: screenHeight*0.02,),
                        widget.name != null?
                        Text(
                          widget.name!.replaceFirst(widget.name![0], widget.name![0].toUpperCase()),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: screenWidth*0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),
                        )
                            : Text(""),
                      ],
                    ),
                    Container(width: screenWidth*0.07,),
                    GestureDetector(
                      onTap: favoritesNumber!=0?(){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=> const SavedRecipes()));
                      }:null,
                      child: Column(
                        children: [
                          Text(
                            "Saved Recipes",
                            style: TextStyle(
                                color: const Color.fromRGBO(169, 169, 169, 1),
                                fontSize: screenWidth * 0.033,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Text(
                            favoritesNumber.toString(),
                            style: TextStyle(
                                color: const Color.fromRGBO(18, 18, 18, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth*0.045,
                                fontFamily: 'Poppins'
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth*0.02,),

                    GestureDetector(
                      child: Column(
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
                            followerStats?.followingCount.toString() ?? "0",
                            style: TextStyle(
                                color: const Color.fromRGBO(18, 18, 18, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth*0.045,
                                fontFamily: 'Poppins'
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=>Followers(chefId: widget.id!, name: widget.name!, follower: false,)));
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight*0.06,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Upgradetochef(email: widget.email),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF12A597), Color(0xFF18A975)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.emoji_food_beverage,
                          color: Colors.white,
                          size: screenWidth * 0.07,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Text(
                          "UPGRADE TO CHEF",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight*0.01,),
                Center(
                  child: GestureDetector(
                    child: Lottie.asset(
                        'assets/chef.json',
                        repeat: false,
                      height: screenHeight*0.5
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context)=> Upgradetochef(email: widget.email,)));
                    },
                  ),
                ),
                //UserProfilePage(email: widget.email),



              ]
          ),
        ),
      ),
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
            Provider.of<UserProvider>(context,listen: false).userDetails?['imageUrl'] != null?ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Remove Profile Picture"),
              onTap: () async{
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateProfileImage(null);
                await userProvider.deleteImage(widget.id!);
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
          await userProvider.updateImage(widget.id!, url);
          await userProvider.fetchUserDetails();
          setState(() {
            userDetails = userProvider.userDetails;
          });
          print("Profile picture updated successfully");
        }else{
          print("Error: Image not uploaded");
        }
      }
    } else {
      print("Image cropping cancelled");
    }
  }

  void _showFullSizeImageDialog(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Transparent background for the dialog
          child: Container(
            width: screenWidth*0.4,
            height: screenHeight*0.4,
            decoration: BoxDecoration(
              color: Colors.transparent, // Keep the container background transparent
              borderRadius: BorderRadius.circular(20), // Rounded corners for the dialog
            ),
            child: Stack(
              children: [
                // Apply blur to the background
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                        color: Colors.transparent
                    ),
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: userProvider.userDetails?['imageUrl'] == null
                        ? const Image(
                      image: AssetImage('assets/images/img.png'),
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      userProvider.userDetails?['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}