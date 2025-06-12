import 'package:flutter/material.dart';


class Stepcountercontainer extends StatefulWidget {
  final int steps;
  const Stepcountercontainer({super.key, required this.steps});

  @override
  State<Stepcountercontainer> createState() => _StepcountercontainerState();
}

class _StepcountercontainerState extends State<Stepcountercontainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: 250,
        width: 350,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
