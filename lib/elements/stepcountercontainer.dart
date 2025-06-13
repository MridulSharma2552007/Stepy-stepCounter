import 'package:flutter/material.dart';

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
  bool clicked = false;
  String getdate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 450,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                getdate(),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white.withValues(alpha: 0.7),
                  fontFamily: 'Plank',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(120, 40, 50, 0),
              child: Text(
                "${widget.steps}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  fontFamily: 'Plank',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      clicked = true;
                    });
                    widget.onStop();
                  },
                  child: InfoBox(
                    text: 'Stop',
                    color:
                        clicked
                            ? Colors.red.withOpacity(0.6)
                            : Colors.white.withOpacity(0.3),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      clicked = false;
                    });
                    widget.onStart();
                  },
                  child: InfoBox(
                    text: 'Start',
                    color:
                        !clicked
                            ? Colors.green.withOpacity(0.6)
                            : Colors.white.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String text;
  final Color color; // new parameter

  const InfoBox({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Plank',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
