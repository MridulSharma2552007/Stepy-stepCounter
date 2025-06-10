import 'package:flutter/material.dart';
import 'package:stepy/Pages/pageview/pagetwo.dart';
import 'package:video_player/video_player.dart';

class Pageone extends StatefulWidget {
  final PageController controller;
  const Pageone({super.key, required this.controller});
  @override
  State<Pageone> createState() => _PageoneState();
}

class _PageoneState extends State<Pageone> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  final TextEditingController _textEditingController = TextEditingController();
  String Name = '';

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/videos/pageonevideo.mp4")
          ..setLooping(true)
          ..setVolume(0);

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();
    setState(() {
      _isInitialized = true;
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose(); // clean up
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
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
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
                        "Enter Your Name",
                        style: TextStyle(
                          fontFamily: 'Plank',
                          color: Colors.white,
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
                              'My NAME IS : ',
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
                                            'Please enter your name',
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
                                        Name = value;
                                      });
                                      widget.controller.animateToPage(
                                        1, //Index

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
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
