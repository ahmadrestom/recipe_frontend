import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/FollowingProvider.dart';
import 'package:recipe_app/models/Follower.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../customerWidgets/FollowUser.dart';

class Followers extends StatefulWidget {
  const Followers({super.key, required this.chefId, required this.name, required this.follower});
  final String chefId;
  final String name;
  final bool follower;

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers>{

  Set<Follower>? _followers;
  Set<Follower>? _followings;
  int nbFollowers = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFollowers();
    });

  }

  void _getFollowers() async{
    final followerProvider = Provider.of<FollowingProvider>(context, listen: false);
    //remove delay
    await Future.delayed(const Duration(seconds: 1));
    //remove delay
    if(widget.follower == true){
      await followerProvider.getAllFollowers(widget.chefId);
      setState(() {
        _followers = followerProvider.followers;
        nbFollowers = _followers!.length;
      });
    }else{
      await followerProvider.getAllFollowings(widget.chefId);
      setState(() {
        _followings = followerProvider.followings;
        nbFollowers = _followings!.length;
      });
    }


  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight *0.03, horizontal: screenWidth*0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 27,
                    color: Color.fromRGBO(41, 45, 50, 1),
                  ),
                ),
                SizedBox(width: screenWidth*0.06,),
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(41, 45, 50, 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.008,
                      horizontal: screenWidth * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 245, 245, 1), // Light gray background
                      borderRadius: BorderRadius.circular(12), // Soft round corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Subtle shadow
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1), // Slightly below
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people,
                          color: const Color.fromRGBO(150, 150, 150, 1),
                          size: screenWidth * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          widget.follower?
                          "$nbFollowers Followers"
                          :"$nbFollowers Followings",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(41, 45, 50, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02,),
            Expanded(
              child: Skeletonizer(
                enableSwitchAnimation: true,
                enabled: (widget.follower && _followers == null) || (!widget.follower && _followings == null),
                child: widget.follower
                    ? (_followers == null
                    ? ListView.builder(
                  itemCount: 10, // Show 10 skeleton items
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(18, 149, 117, 0.1),
                      ),
                      title: Container(
                        height: 15,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(18, 149, 117, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      subtitle: Container(
                        height: 12,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(18, 149, 117, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    );
                  },
                )
                    : _followers!.isEmpty
                    ? Center(
                  child: Text(
                    "No followers yet",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _followers!.length,
                  itemBuilder: (context, index) {
                    final list = _followers!.toList();
                    return FollowUser(
                      name: "${list[index].firstName} ${list[index].lastName}",
                      imageUrl: list[index].imageUrl,
                      role: list[index].role,
                      id: list[index].id,
                    );
                  },
                ))
                    : (_followings == null
                    ? ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromRGBO(18, 149, 117, 0.1),
                      ),
                      title: Container(
                        height: 15,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(18, 149, 117, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      subtitle: Container(
                        height: 12,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(18, 149, 117, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    );
                  },
                )
                    : _followings!.isEmpty
                    ? Center(
                  child: Text(
                    "You haven't followed any chef yet",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _followings!.length,
                  itemBuilder: (context, index) {
                    final list = _followings!.toList();
                    return Column(
                      children: [
                        FollowUser(
                          name: "${list[index].firstName} ${list[index].lastName}",
                          imageUrl: list[index].imageUrl,
                          role: list[index].role,
                          id: list[index].id,
                        ),
                      ],
                    );
                  },
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}