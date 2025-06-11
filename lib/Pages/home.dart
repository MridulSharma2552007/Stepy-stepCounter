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
  @override
  void initState() {
    super.initState();
    initpedometer();
  }

  String getTodayDate() {
    DateTime now = DateTime.now();
    return ('${now.year}-${now.month}-${now.day}');
  }

  Future<void> initpedometer() async {
    _stepCounterStream = Pedometer.stepCountStream;
    _stepCounterStream.listen(
      onStepCount,
      onError: onStepCounterError,
      cancelOnError: true,
    );
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void onStepCounterError(error) {
    print('Error $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Images/background.jpg'),
          Center(child: Text("$_steps", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
