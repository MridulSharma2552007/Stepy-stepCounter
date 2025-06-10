import 'package:flutter/material.dart';
import 'package:stepy/Pages/pageview/pageone.dart';
import 'package:stepy/Pages/pageview/pagetwo.dart';

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
      Pageone(controller: _pageController),
      Pagetwo(controller: _pageController,)
    ],
    ));
  }
}
