import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reshape_project/screens/chat_screen.dart';
import 'package:reshape_project/screens/wrapping_progress_indicator_screen.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 230,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WrappingProgressIndicatorScreen()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: CupertinoColors.systemPurple,
                ),
                child: const Text(
                  "Wrapping Progress Indicator",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 230,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowCaseWidget(
                                builder: Builder(builder: (context) {
                                  return const ChatScreen();
                                }),
                              )));
                },
                style: TextButton.styleFrom(
                  backgroundColor: CupertinoColors.systemPurple,
                ),
                child: const Text(
                  "Chat Screen, tutorial and TTS",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
