import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:radio_grouped_buttons/custom_buttons/custom_radio_buttons_group.dart';
import '../customerWidgets/RecipeInformationCard.dart';
import '../models/recipe.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeInformation extends StatefulWidget {
  RecipeInformation({super.key, required this.recipe});
  final Recipe recipe;
  String selectedOption = "Ingredients";


  @override
  State<RecipeInformation> createState() => _RecipeInformationState();
}

class _RecipeInformationState extends State<RecipeInformation> {
  final TextEditingController _controller = TextEditingController(text: "https://google.com");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 12, 30, 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Icon(Icons.share, size: 20,),
                          SizedBox(width: 30,),
                          Text(
                            "Share",
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight:  MediaQuery.of(context).size.height * 0.38,
                                  ),
                                  child: AlertDialog(
                                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                                    title: const Text(
                                      "Recipe Link",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        const Text(
                                          "Copy recipe link and share your recipe link with friends and family.",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Color.fromRGBO(121, 121, 121, 1),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        CupertinoTextField(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          readOnly: true,
                                          enabled: false,
                                          controller: _controller,
                                          suffix: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              backgroundColor: MaterialStateProperty.all(
                                                const Color.fromRGBO(18, 149, 117, 1),
                                              ),

                                            ),
                                            onPressed: (){
                                              /////////////////////////////////
                                            },
                                            child: const Text(
                                              "Copy Link",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: Color.fromRGBO(255, 255, 255, 1),
                                              ),
                                            ),
                                          ),

                                        ),
                                      ],
                                    ),


                                  ),
                                ),
                              ),
                            );
                          }
                        );
                      },
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Row(
                        children: [
                          Icon(Icons.star, size: 20,),
                          SizedBox(width: 30,),
                          Text(
                            "Rate Recipe",
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.16,
                                  width: MediaQuery.of(context).size.width * 0.54,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "Rate Recipe",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color.fromRGBO(18, 18, 18, 1),
                                        ),
                                      ),
                                      const SizedBox(height: 5.0,),
                                      RatingBar.builder(
                                        itemPadding: const EdgeInsets.only(right: 3),
                                        glowColor: Colors.amberAccent,
                                        unratedColor: const Color.fromRGBO(100,100,100,1),
                                        minRating: 1,
                                        maxRating: 5,
                                        itemSize: 25.0,
                                        allowHalfRating: true,
                                        initialRating: 0,
                                        itemBuilder: (context, index)=>const Icon(
                                          Ionicons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating){
                                          print(rating);
                                        }
                                      ),
                                      const SizedBox(height: 10.0,),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(18, 149, 117, 1),
                                          )
                                        ),
                                          onPressed: (){
                                            ///////////////////////////////////////
                                          },
                                          child: const Text(
                                            "Rate",
                                            style: TextStyle(
                                              color: Color.fromRGBO(255, 255, 255, 1),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                            ),

                                          ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Row(
                        children: [
                          Icon(Icons.rate_review_sharp, size: 20,),
                          SizedBox(width: 30,),
                          Text(
                            "Review",
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
                            builder: (context) => RecipeInformation(recipe: widget.recipe),
                          ),
                        );
                      },
                    ),
                  ]
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  RecipeInformationCard(recipe:widget.recipe),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          //overflow: TextOverflow.ellipsis,
                          widget.recipe.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      Text(
                        "(${widget.recipe.getNumberOfReviews()} Reviews)",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(140, 140, 140, 1)
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.transparent),
                      ),

                      child: Image.asset(
                        "assets/icons/defaultProfile.png",
                      ),
                      /*child: widget.recipe.chef.imageUrl == null?
                      Image.asset(
                        "assets/icons/defaultProfile.png",
                      ):
                      Image.network(

                      ),*/
                    ),
                    const SizedBox(width: 8.0,),
                    Column(
                      children: [
                        Text(
                          "${widget.recipe.chef.firstName} ${widget.recipe.chef.firstName}",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(18, 18, 18, 1),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(113, 177, 161, 1),
                            ),
                            Text(
                              widget.recipe.chef.location,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Color.fromRGBO(140, 140, 140, 1)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                ),
                ElevatedButton(
                  onPressed: (){
                    /////////////////
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(18, 149, 117, 1),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadioButton(
                  buttonLables: const ["Ingredients", "Procedure"],
                  buttonValues: const ["Ingredients", "Procedure"],
                  radioButtonValue: (value,index){
                    setState(() {
                      widget.selectedOption = value;
                    });
                  },
                  horizontal: true,
                  buttonWidth: MediaQuery.of(context).size.width * 0.38,
                  enableShape: false,
                  buttonSpace: 5,
                  elevation: 5,
                  buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                  selectedColor: const Color.fromRGBO(18, 149, 117, 1),
                  selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                  textColor: const Color.fromRGBO(113, 177, 161, 1),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.ramen_dining_sharp,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),
                    Text(
                      "1 serve",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(169, 169, 169, 1),
                      ),
                    )
                  ],
                ),
                if(widget.selectedOption == "Ingredients")
                  Text(
                    "${widget.recipe.ingredients.length} Items",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),

                  ),
                if(widget.selectedOption == "Procedure")
                  Text(
                    "${widget.recipe.instructions.length} Steps",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(169, 169, 169, 1),
                    ),
                  ),
              ],
            ),
            
            if(widget.selectedOption == "Ingredients")
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(13, 7, 13, 0),
                  child: ListView.builder(
                    itemCount: widget.recipe.ingredients.length,
                    itemBuilder: (context, index){
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.recipe.ingredients[index].name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color.fromRGBO(18, 18, 18, 1),
                                ),
                              ),
                            ),
                            Text(
                              "${widget.recipe.ingredients[index].grams} g",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromRGBO(155, 155, 155, 1),

                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            if(widget.selectedOption == "Procedure")
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(13, 7, 13, 0),
                  child: ListView.builder(
                    itemCount: widget.recipe.instructions.length,
                    itemBuilder: (context, index){
                      return Container(
                        constraints: const BoxConstraints(minHeight: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(217, 217, 217, 1),
                        ),
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Step ${index+1} ",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color.fromRGBO(18, 18, 18, 1),
                              ),
                            ),
                            Text(
                              widget.recipe.instructions[index],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromRGBO(169, 169, 169, 1),
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
}
