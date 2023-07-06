import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_event.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    context.read<WeatherBloc>().add(GetWeatherEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext context, state) {
          if(state is WeatherInitial){
            return const Text('a');
          }else if(state is WeatherLoaded){
            return Text((state.weather['parent']['title']));
          }
          return Container();
        },),
    );
  }
}