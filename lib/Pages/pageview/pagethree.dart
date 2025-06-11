import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepy/Pages/home.dart';
import 'package:video_player/video_player.dart';

class Pagethree extends StatefulWidget {
  const Pagethree({super.key});

  @override
  State<Pagethree> createState() => _PagethreeState();
}

class _PagethreeState extends State<Pagethree> {
  bool initialize = false;
  late VideoPlayerController _controller;
  final TextEditingController _textEditingController = TextEditingController();
  String? selectedGender = 'Male';
  String goalSteps = '';
  Future<void> completeOnBoard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/pagethreevideo.mp4',
    );
    _controller.setLooping(true);
    _controller.setVolume(0);
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _controller.initialize();
    setState(() {
      completeOnBoard();
      initialize = true;
    });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          initialize
              ? Stack(
                children: [
                  // Background Video
                  Positioned.fill(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),

                  // Foreground Content Scrollable
                  Positioned.fill(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 80,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 450),
                          // Goal Steps Input
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'ENTER YOUR DAILY GOAL',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Plank',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          controller: _textEditingController,
                                          onSubmitted: (value) {
                                            if (_textEditingController
                                                .text
                                                .isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Please Enter Your Daily Step Goal',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.black,
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                goalSteps = value;
                                              });
                                            }
                                          },
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            fontFamily: 'Plank',
                                          ),
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

                          SizedBox(height: 30),

                          // Gender Selection
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'Select Your Gender',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Plank',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children:
                                            ['Male', 'Female'].map((option) {
                                              return Expanded(
                                                child: RadioListTile<String>(
                                                  title: Text(
                                                    option,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Plank',
                                                    ),
                                                  ),
                                                  value: option,
                                                  groupValue: selectedGender,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      selectedGender = val;
                                                    });
                                                  },
                                                  activeColor: Colors.white,
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 120), // Leave space for button
                        ],
                      ),
                    ),
                  ),

                  // Get Started Button
                  Positioned(
                    bottom: 30,
                    left: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (_textEditingController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please Your Daily GGoal',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        }
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Plank',
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white.withOpacity(0.5),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator()),
    );
  }
}
