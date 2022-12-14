import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/model/model_weather.dart';


final dataProvider = FutureProvider.family.autoDispose<ModelWeather, String>((ref, param) async {
  try {
    final Uri uri = Uri.https(
      CommonConstants.baseUrl,
      '/data/2.5/weather',
      {'q': param, 'appid': CommonConstants.apiKey},
    );

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    final decodeRes = json.decode(response.body);
    log('getWeatherData ${response.body} ');

    return ModelWeather.fromJson(decodeRes);
  } on HttpException catch (e) {
    log('getWeatherData Catch $e');
    rethrow;
    // return null;
  }
});


final weatherProvider = StateNotifierProvider.autoDispose<WeatherNotifier, AsyncValue<ModelWeather ?>>((ref) {
  return WeatherNotifier();
});

class WeatherNotifier extends StateNotifier<AsyncValue<ModelWeather ?>> {
  // final AutoDisposeStateNotifierProviderRef _ref;
  WeatherNotifier(): super(const AsyncValue.loading());


 Future<void> call(String param) async {
    try {
      final Uri uri = Uri.https(
        CommonConstants.baseUrl,
        '/data/2.5/weather',
        {
          'q': param,
          'units': 'metric',
          'appid': CommonConstants.apiKey,
        },
      );

      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      final decodeRes = json.decode(response.body);

      state = AsyncValue.data(ModelWeather.fromJson(decodeRes));
    } on HttpException catch (e) {
      log('getWeatherData Catch $e');
      rethrow;
    }
  }
}