import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Distance extends StatefulWidget {
  final int distanceSteps;

  const Distance({super.key, required this.distanceSteps});

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  String gender = 'Male'; // default gender

  @override
  void initState() {
    super.initState();
    loadGender();
  }

  Future<void> loadGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedGender = prefs.getString('usrrGender') ?? 'Male';
    setState(() {
      gender = storedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use stride length based on gender
    double stride = gender == 'Female' ? 0.70 : 0.78;
    double currentDistance = (widget.distanceSteps * stride) / 1000; // in km

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            '${currentDistance.toStringAsFixed(2)} km',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Plank',
            ),
          ),
        ),
      ),
    );
  }
}
