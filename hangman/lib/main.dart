import 'package:flutter/material.dart';
import 'package:hangman/Screens/game_screen.dart';
import 'package:hangman/Screens/home_screen.dart';
import 'package:hangman/Screens/score_screen.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/game': (context) => GameScreen(),
    '/scores': (context) => ScoreScreen(),
  },
));

