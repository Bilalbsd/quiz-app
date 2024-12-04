import 'package:flutter/material.dart';
import 'package:tp1_flutter_bilalb/display/quiz_display.dart';
import 'display/profile_display.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP1 Flutter BilalBsd',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProfileHomePage(),
        '/quiz': (context) => const QuizPage(title: 'Page de Quiz'),
      },
    );
  }
}
