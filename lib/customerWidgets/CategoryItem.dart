import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryItem({
    Key? key,
    required this.categoryName,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = categoryName == selectedCategory;

    return Container(
      height: 32,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromRGBO(18, 149, 117, 1) : const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            onCategorySelected(categoryName);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            categoryName,
            style: TextStyle(
              color: isSelected ? const Color.fromRGBO(255, 255, 255, 1):const Color.fromRGBO(113, 177, 161, 1),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
