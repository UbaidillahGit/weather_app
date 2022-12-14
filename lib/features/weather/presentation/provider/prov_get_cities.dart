
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllCitesProvider = FutureProvider.autoDispose<dynamic>((ref) async {
  try {
    log('getAllCitesProvider fired');
  //  final String response = await rootBundle.loadString('assets/cities.json');
  // log('resDecoded ${response }');
    // final resDecoded = await json.decode(response);
    // return ModelCities.fromJson(data);
    
  } catch (e) {
    log('getAllCitesProvider Catch $e');
    rethrow;
  }
});