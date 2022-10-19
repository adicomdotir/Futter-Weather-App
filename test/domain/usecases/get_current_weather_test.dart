import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/entities/weather.dart';
import 'package:flutter_weather_app/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  final testWeatherDetail = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tCityName = 'Jakarta';

  test(
    'should get current weather detail from the repository',
    () async {
      // arrange
      when(mockWeatherRepository.getCurrentWeather(tCityName))
          .thenAnswer((_) async => Right(testWeatherDetail));

      // act
      final result = await usecase.execute(tCityName);

      // assert
      expect(result, equals(Right(testWeatherDetail)));
    },
  );
}
