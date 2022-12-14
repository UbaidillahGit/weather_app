import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemComponents extends StatelessWidget {
  const ItemComponents({super.key, required this.title, required this.value, required this.metric});

  final String title;
  final String value;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          metric,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Stack(
        //   children: [
        //     Container(
        //       height: 5,
        //       width: 50,
        //       color: Colors.white38,
        //     ),
        //     Container(
        //       height: 5,
        //       // width: locationList[index].wind/2,
        //       width: 10,
        //       color: Colors.greenAccent,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}