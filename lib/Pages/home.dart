import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:stepy/elements/stepcountercontainer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<StepCount> _stepCounterStream;
  int _steps = 0;
  int? _startedSteps;
  bool _isTracking = false;
  @override
  void initState() {
    super.initState();
    initializeCounter();
  }

  Future<void> initializeCounter() async {
    _stepCounterStream = Pedometer.stepCountStream;
    _stepCounterStream.listen(
      onStepCounter,
      onError: onErrorStepCounter,
      cancelOnError: true,
    );
  }

  void onStepCounter(StepCount event) {
    if (_isTracking) {
      _startedSteps ??= event.steps;
      int runSteps = event.steps - _startedSteps!;
      setState(() {
        _steps = runSteps;
      });
    }
  }

  void onErrorStepCounter(e) {
    print("ERROR : $e");
  }

  void onStopTrancking() {
    setState(() {
      _isTracking = false;
    });
  }

  void onStartTracking() {
    setState(() {
      _isTracking = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Images/background.jpg', fit: BoxFit.cover),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  Stepcountercontainer(
                    steps: _steps,
                    onStart: () {
                      onStartTracking();
                    },
                    onStop: () {
                      onStopTrancking();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
