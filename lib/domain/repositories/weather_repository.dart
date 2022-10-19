import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<dynamic, dynamic>> getCurrentWeather(String cityName);
}
