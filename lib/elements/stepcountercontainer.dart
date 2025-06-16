import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stepcountercontainer extends StatefulWidget {
  final VoidCallback onStart;
  final VoidCallback onStop;
  final int steps;

  const Stepcountercontainer({
    super.key,
    required this.steps,
    required this.onStart,
    required this.onStop,
  });

  @override
  State<Stepcountercontainer> createState() => _StepcountercontainerState();
}

class _StepcountercontainerState extends State<Stepcountercontainer> {
  bool isTracking = false;

  String getdate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                getdate(),
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white.withOpacity(0.8),
                  fontFamily: 'Plank',
                ),
              ),
            ),

            // Steps Count
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Text(
                  '${widget.steps}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 90,
                    fontFamily: 'Plank',
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => isTracking = false);
                    widget.onStop();
                  },
                  child: AnimatedInfoBox(
                    text: 'Stop',
                    isActive: !isTracking,
                    activeColor: Colors.redAccent.withOpacity(0.6),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => isTracking = true);
                    widget.onStart();
                  },
                  child: AnimatedInfoBox(
                    text: 'Start',
                    isActive: isTracking,
                    activeColor: Colors.greenAccent.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class AnimatedInfoBox extends StatelessWidget {
  final String text;
  final bool isActive;
  final Color activeColor;

  const AnimatedInfoBox({
    super.key,
    required this.text,
    required this.isActive,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: 70,
      width: 120,
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow:
            isActive
                ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ]
                : [],
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Plank',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(isActive ? 0.95 : 0.6),
          ),
        ),
      ),
    );
  }
}
