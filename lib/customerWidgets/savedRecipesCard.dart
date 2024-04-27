import 'package:flutter/material.dart';

import '../models/recipe.dart';

class SavedRecipe extends StatelessWidget {
  const SavedRecipe({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red)
      ),
      height: 150,
      child: Stack(
        children: [
          Image.asset(
            recipe.imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
