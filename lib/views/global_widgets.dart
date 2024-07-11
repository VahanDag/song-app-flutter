import 'package:flutter/material.dart';

Container imageContainerTop(String imageName, String title) {
  return Container(
    width: double.infinity,
    height: 200,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
            fit: BoxFit.cover,
            image: AssetImage("assets/images/$imageName.png"))),
    child: Text(
      title.toUpperCase(),
      style: const TextStyle(letterSpacing: 2, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
    ),
  );
}
