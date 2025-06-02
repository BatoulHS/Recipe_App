import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.category, required this.onPressed});

  final Category category;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          // backgroundColor: Colors.white,
          // foregroundColor: Colors.black,
          minimumSize: const Size(150, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Text(
          category.name[0].toUpperCase() + category.name.substring(1),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
