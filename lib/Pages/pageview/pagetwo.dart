import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Pagetwo extends StatefulWidget {
  final PageController controller;
  const Pagetwo({super.key, required this.controller});

  @override
  State<Pagetwo> createState() => _PagetwoState();
}

class _PagetwoState extends State<Pagetwo> {
  bool _isInitialized = false;
  late VideoPlayerController controller;
  final TextEditingController _textEditingController = TextEditingController();
  String age = '';
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/videos/pagetwovideo.mp4');
    controller.setLooping(true);
    controller.setVolume(0);
    _initilizeVideoPlayer();
  }

  Future<void> _initilizeVideoPlayer() async {
    await controller.initialize();
    setState(() {
      _isInitialized = true;
    });
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          _isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  Positioned(
                    bottom: 350,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Enter Your Age",
                        style: TextStyle(
                          fontFamily: 'Plank',
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'My Age IS : ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Plank',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  25,
                                  10,
                                  10,
                                  5,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only allow digits
                                  ],
                                  showCursor: false,
                                  controller: _textEditingController,
                                  onSubmitted: (value) {
                                    if (_textEditingController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          // Use const for SnackBar if content is const
                                          content: Text(
                                            'Please Your Age',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor:
                                              Colors.black, // Make it stand out
                                          duration: Duration(
                                            seconds: 2,
                                          ), // How long it shows
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        age = value;
                                      });
                                      widget.controller.animateToPage(
                                        2, //Index

                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Plank',
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator()),
    );
  }
}
