import 'package:flutter/material.dart';
import 'package:radio_grouped_buttons/custom_buttons/custom_radio_buttons_group.dart';
import 'package:recipe_app/pages/Data/recipes.dart';
import '../customerWidgets/RecipeInformationCard.dart';
import '../models/recipe.dart';

class RecipeInformation extends StatefulWidget {
  RecipeInformation({super.key, required this.recipe});
  final Recipe recipe;
  String selectedOption = "Ingredients";

  @override
  State<RecipeInformation> createState() => _RecipeInformationState();
}

class _RecipeInformationState extends State<RecipeInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 25, 30, 25),
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

                GestureDetector(
                  onTap: (){
                    ////////////////////////////////
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    size: 27,
                    color: Color.fromRGBO(41, 45, 50, 1),
                  ),
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
                        constraints: BoxConstraints(minHeight: 50),
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
