import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reshape_project/screens/home_page_screen.dart';
import 'package:reshape_project/screens/wrapping_progress_indicator_screen.dart';

void main() {
  runApp(const MyApp());
}

/*1. Create a chat interface that can speak text as it streams. Think about an end-to-end seamless experience of this with the user. We can give you a temporary OpenAI key to implement this.
2. Create a tutorial overlay system to help user understand controls of the above interface. This should have minimum of 3 steps in the tutorial. The user can go previous or next. User also should be able be minimum of one action while being in tutorial.
3. Implement a progress bar that wrap around a card (as in Reshape Home Screen).
       OR
       Implement sound wave animations that move as the user speaks. You can get reference from Reshape's voice-tracking.
OR
Make the cards (as on Reshape's home screen) flip, the front view should be what's there already. The back view should have some placeholder text/paragraph.*/

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageScreen(),
    );
  }
}
