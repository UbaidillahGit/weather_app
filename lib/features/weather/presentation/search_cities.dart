import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCities extends ConsumerWidget {
  SearchCities({super.key});

  final List<String> cities = [
    'London',
    'Tokyo',
    'New York',
    'Singapore',
    'Delhi',
    'Shanghai',
    'Manila',
    'Seoul',
    'Cairo',
    'Kolkata',
    'Jakarta',
    'Bandung',
    'Surabaya',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dataCities = ref.watch(getAllCitesProvider);

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pop(cities[index]);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cities[index],
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
            ),
          );
        },
        itemCount: cities.length,
      ),
    );
  }
}