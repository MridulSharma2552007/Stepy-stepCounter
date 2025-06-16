import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stepy/elements/distance.dart';
import 'package:stepy/elements/stepcountercontainer.dart';
import 'package:stepy/elements/userintro.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<StepCount> _stepCounterStream;
  int _steps = 0;
  int? _todayStartSteps;
  bool _isTracking = false;
  late VideoPlayerController _controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCounter();
    _controller = VideoPlayerController.asset('assets/videos/bgvideo.mp4');
    _controller.setLooping(false);
    _controller.setVolume(0);
    initializePlayer();
  }

  void initializePlayer() async {
    await _controller.initialize();
    setState(() {
      isInitialized = true;
    });
    _controller.play();
  }

  String getTodayDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initializeCounter() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedDate = prefs.getString('stepDate');
    int? storedSteps = prefs.getInt('startSteps');
    final today = getTodayDate();

    _stepCounterStream = Pedometer.stepCountStream;
    _stepCounterStream.listen(
      (event) async {
        if (storedDate != today || storedSteps == null) {
          await prefs.setString('stepDate', today);
          await prefs.setInt('startSteps', event.steps);
          _todayStartSteps = event.steps;
        } else {
          _todayStartSteps = storedSteps;
        }

        if (_isTracking && _todayStartSteps != null) {
          setState(() {
            _steps = event.steps - _todayStartSteps!;
          });
        }
      },
      onError: onErrorStepCounter,
      cancelOnError: true,
    );
  }

  void onErrorStepCounter(e) {
    print("ERROR: $e");
  }

  void onStartTracking() {
    setState(() {
      _isTracking = true;
    });
  }

  void onStopTracking() {
    setState(() {
      _isTracking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          isInitialized
              ? Stack(
                fit: StackFit.expand,

                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          Userintro(),
                          Stepcountercontainer(
                            steps: _steps,
                            onStart: onStartTracking,
                            onStop: onStopTracking,
                          ),
                          Distance(),
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
