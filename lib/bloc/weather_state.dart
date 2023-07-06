import 'package:equatable/equatable.dart';

class WeatherState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState{}

class WeatherLoaded extends WeatherState{
  final weather;
  WeatherLoaded({this.weather});
}

class WeatherError extends WeatherState{}