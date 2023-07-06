import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/repo.dart';
import 'package:weather_app/presentation/home_page.dart';

import 'bloc/weather_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(Repo()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

