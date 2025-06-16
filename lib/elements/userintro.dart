import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userintro extends StatefulWidget {
  const Userintro({super.key});

  @override
  State<Userintro> createState() => _UserintroState();
}

class _UserintroState extends State<Userintro> {
  @override
  void initState() {
    loadUserName();
    super.initState();
  }

  String userName = '';
  void loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('userName');
    if (name != null) {
      setState(() {
        userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            userName.isNotEmpty
                ? Padding(
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
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                : SizedBox(),
      ),
    );
  }
}
