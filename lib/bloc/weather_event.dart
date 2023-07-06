import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class WeatherEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetWeatherEvent extends WeatherEvent{
  final cityName;
  GetWeatherEvent({@required this.cityName});
}