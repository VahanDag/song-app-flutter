import 'package:flutter/material.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tasarlayan",
            style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "VAHAN DAĞ",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(offset: Offset(5, 5), color: Colors.grey, blurRadius: 2)]),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Muhammet DAĞ için tasarlandı..",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
