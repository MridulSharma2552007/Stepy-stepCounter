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
  bool clicked = false;
  String userName = '';

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  void loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('userName');
    if (name != null) {
      setState(() {
        userName = name;
      });
    }
  }

  String getdate() {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
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
                  fontSize: 30,
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'Plank',
                ),
              ),
            ),

            // Steps Count
            Padding(
              padding: const EdgeInsets.fromLTRB(120, 40, 50, 0),
              child: Text(
                '${widget.steps}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  fontFamily: 'Plank',
                ),
              ),
            ),

            // Buttons
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

            // 👇 Name Display
            if (userName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Hello, $userName!',
                    style: TextStyle(
                      fontFamily: 'Plank',
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
