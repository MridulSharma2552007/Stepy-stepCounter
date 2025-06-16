import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Distance extends StatefulWidget {
  final int distanceSteps;
  const Distance({super.key, required this.distanceSteps});

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  String gender = '';
  double distanceInKm = 0;

  @override
  void initState() {
    super.initState();
    loadDistance();
  }

  Future<void> loadDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('usrrGender') ?? 'Male'; // fallback to 'Male'
    setState(() {
      distanceInKm = calcDistance();
    });
  }

  double calcDistance() {
    const double maleStride = 0.78;
    const double femaleStride = 0.70;
    double stride = gender == 'Female' ? femaleStride : maleStride;
    return (widget.distanceSteps * stride) / 1000; // Convert to KM
  }

  @override
  Widget build(BuildContext context) {
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
            '${distanceInKm.toStringAsFixed(2)} km',
            style: TextStyle(
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
