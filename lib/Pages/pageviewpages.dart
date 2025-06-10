import 'package:flutter/material.dart';
import 'package:stepy/Pages/pageone.dart';

class Pageviewpages extends StatefulWidget {
  const Pageviewpages({super.key});

  @override
  State<Pageviewpages> createState() => _PageviewpagesState();
}

class _PageviewpagesState extends State<Pageviewpages> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageView(controller: _pageController,
    children: [
      Pageone()
    ],
    ));
  }
}
