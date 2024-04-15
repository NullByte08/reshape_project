import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:word_generator/word_generator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  bool _playedTTS = false;

  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initFlutterTTS();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  _initFlutterTTS() {
    if (Platform.isIOS) {
      flutterTts.setSharedInstance(true);
      flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }

    flutterTts.awaitSpeakCompletion(true);
    flutterTts.awaitSynthCompletion(true);
    flutterTts.setLanguage("en-US");

    flutterTts.setSpeechRate(0.5);

    flutterTts.setVolume(1.0);
  }

  final List<MessageModel> _messages = [
    MessageModel("Hello there! How can I help you!!", false),
  ];

  Future getAISampleAnswer() async {
    await Future.delayed(const Duration(seconds: 2), () {});

    final wordGenerator = WordGenerator();
    String randomSentence = wordGenerator.randomSentence(10);
    print("Random sentence: $randomSentence");
    _messages.insert(0, MessageModel(randomSentence, false));
    _playedTTS = false;
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder();

    if (!_playedTTS) {
      if (!_messages[0].byUser) {
        flutterTts.speak(_messages[0].message);
      }
      _playedTTS = true;
    }
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Chat screen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: _messages[index].byUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          LimitedBox(
                            maxWidth: screenWidth * 0.5,
                            child: Showcase(
                              key: _three,
                              description: "Ai will write your text here",
                              child: Container(
                                color: Colors.redAccent,
                                padding: const EdgeInsets.all(8),
                                child: index == 0 && !_messages[index].byUser
                                    ? AnimatedTextKit(
                                        key: ValueKey(_messages[index].message),
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            _messages[index].message,
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                            ),
                                            speed: const Duration(milliseconds: 50),
                                          ),
                                        ],
                                        totalRepeatCount: 1,
                                        pause: const Duration(milliseconds: 100),
                                        displayFullTextOnTap: false,
                                        stopPauseOnTap: false,
                                      )
                                    : Text(
                                        _messages[index].message,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (_messages.isNotEmpty && _messages[0].byUser) const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Showcase(
                  key: _one,
                  description: 'Enter your message here. Type "Hello"',
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter message",
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      suffixIcon: InkWell(
                        onTap: () {
                          if (_controller.text.trim().isNotEmpty) {
                            _messages.insert(0, MessageModel(_controller.text, true));
                            _controller.text = "";
                            setState(() {});
                            getAISampleAnswer();
                          }
                        },
                        child: Showcase(
                          key: _two,
                          description: "Send from here",
                          child: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class MessageModel {
  String message;
  bool byUser;

  MessageModel(this.message, this.byUser);
}
