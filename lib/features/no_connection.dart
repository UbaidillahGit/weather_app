import 'package:flutter/material.dart';
import 'package:weather_app/features/splash/splash_page.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  Future<bool> _willPopCallback(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashPage()), 
      (route) => false
    );
    return true; // return true if the route to be popped
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: Scaffold(
        body: Center(child: Image.asset('assets/no_internet.gif')),
      ),
    );
  }
}