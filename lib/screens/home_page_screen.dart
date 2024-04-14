
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reshape_project/screens/wrapping_progress_indicator_screen.dart';

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
            TextButton(
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
            TextButton(
              onPressed: () {
                //todo
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
            TextButton(
              onPressed: () {
                //todo
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
          ],
        ),
      ),
    );
  }
}
