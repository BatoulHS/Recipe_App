import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget{
  const HomeScreen ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ListView(
            children: [
              Text(
                "Hello Chef,", 
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "What are you cooking today?",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )
        ),
    );
  }

  
}