import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;
  final double width = 200.0;
  final double height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(child: Image.asset(recipe.imageUrl, fit:BoxFit.cover,width: width,height: height,)),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 1),
                  Color.fromRGBO(0, 0, 0, 0),
                ]
              )
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 0, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Text(
                  'By Chef ${recipe.chef}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 9.0,
                    color: Color.fromRGBO(169, 169, 169, 1)

                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 48,
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
                  ),
                  const SizedBox(width: 2.0,),
                  Text(
                      (recipe.rating).toString()
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
