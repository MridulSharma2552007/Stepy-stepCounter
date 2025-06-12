import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

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
      if (_startedSteps == null) {
        _startedSteps = event.steps;
      }
      int runSteps = event.steps - _startedSteps!;
      setState(() {
        _steps = runSteps;
      });
    }
  }

  void onErrorStepCounter(e) {
    print("ERROR : $e");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [Image.asset('assets/Images/background.jpg'), Column(
          children: [
            
          ],


        )],
      ),
    );
  }
}
