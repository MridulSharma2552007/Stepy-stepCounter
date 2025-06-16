import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Distance extends StatefulWidget {
  const Distance({super.key});

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  @override
  void initState() {
    super.initState();
    loadDistance();
  }

  String Gender = '';

  void loadDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Gender = prefs.getString('usrrGender')!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      child: Container(
        height: 250,

        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.5),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
