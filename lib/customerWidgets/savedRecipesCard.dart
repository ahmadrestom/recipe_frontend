import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../models/recipe.dart';

class SavedRecipe extends StatelessWidget {
  const SavedRecipe({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(recipe.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 1),
                    Color.fromRGBO(0, 0, 0, 0),
                  ]
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 15, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 50,
                height: 23,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 225, 179, 1),
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 173, 48, 1),
                      size: 18,
                    ),
                    Text(
                        (recipe.rating).toString(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(17, 0, 17, 17),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        "By Chef ${recipe.chef}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
            
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined, color: Color.fromRGBO(145, 145, 145, 1),
                      size: 24,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "${recipe.preparationTime.inMinutes} Mins",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ),
                    const SizedBox(width: 13,),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color.fromRGBO(255, 255, 255, 1)
                      ),
                      child: GestureDetector(
                        child: const Icon(
                          Ionicons.bookmark,
                          color: Color.fromRGBO(18, 149, 117, 1),
                          size: 18,
                        ),
                        onTap: (){
                          ////////////////////////////////////
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
