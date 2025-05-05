import 'package:flutter/material.dart';
import 'tela_de_start.dart'; 

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz de Nemo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizStartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(QuizApp());
}