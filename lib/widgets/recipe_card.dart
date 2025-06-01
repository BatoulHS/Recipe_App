import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/screens/recipe_details.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard ({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => RecipeDetails(recipe: recipe,),),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(Icons.favorite_border_outlined),
              Row(
                children: [
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Image.file(
                      File(recipe.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          recipe.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          maxLines: 2, // Limits to 2 lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        recipe.category.name,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 105, 104, 104),
                        ),
                      ),
                      SizedBox(height: 2.5),
                      // Text("⏲ 1:30 \t\t Medium"),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, size: 16),
                          SizedBox(width: 4),
                          Text(recipe.formatedDuration),
                          SizedBox(width: 25),
                          Text(recipe.difficulty.name),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
