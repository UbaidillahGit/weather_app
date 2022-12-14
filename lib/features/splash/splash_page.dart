import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/no_connection.dart';
import 'package:weather_app/features/weather/presentation/weather_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // bool get kDebugMode => null;


  @override
  void initState() {
    super.initState();
    _chcekConnection();
  }

  void _chcekConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('connected');
        }
        _routeToHome();
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('not connected');
      }
      _routeToNoInternet();
    }
  }

  void _routeToNoInternet() => Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const NoConnectionPage()
        ),
        (route) => false,
      );
    });

  void _routeToHome() => Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const WeatherPage(),
        ),
        (route) => false,
      );
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // '${data?.main?.temp!.round()} \u2109',
              'Weather App',
              style: GoogleFonts.lato(
                fontSize: 55,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            Text(
              // '${data?.main?.temp!.round()} \u2109',
              'Checking internet connection...',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}