import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:weather_app/data/models/weather.dart';

import '../data/repository/repo.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Repo repo;
  WeatherBloc(this.repo) : super(WeatherInitial()) {
    on<GetWeatherEvent>(onWeatherChange);
  }

  onWeatherChange(GetWeatherEvent getWeatherEvent, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherData = await repo.getApiData();

      if(getWeatherEvent.cityName == 'london' || getWeatherEvent.cityName == null ) {
        emit(WeatherLoaded(weather: weatherData));
      }else{
        emit(WeatherError(city: getWeatherEvent.cityName));
      }
    } catch (e){
      emit(WeatherError());
    }


  }
}
