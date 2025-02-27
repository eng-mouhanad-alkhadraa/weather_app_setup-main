import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '87224dd36244409c867162511240205';
  WeatherService(this.dio);

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String erroMessage = e.response?.data['error']
              ['message'] ?? 
          'Oop There Was An Error , Try Later'; 
      throw Exception(erroMessage);
    } catch (e) {
      log(e.toString()); 
      throw Exception('Oop There Was An Error , Try Later');
    }
  }
}
