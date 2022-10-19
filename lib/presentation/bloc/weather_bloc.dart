import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_event.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;

  WeatherBloc(this.getCurrentWeather) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result = await getCurrentWeather.execute(event.cityName);
      result.fold((failure) => emit(WeatherError(failure.message)),
          (success) => emit(WeatherHasData(success)));
    });
  }
}
