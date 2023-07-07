import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/presentation/screens/settings_page.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_state.dart';
import '../widgets/my_text.dart';
import 'search_city.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? prefs;

  checkTemp() async {
    prefs = await SharedPreferences.getInstance();

  }

  @override
  void initState() {

    context.read<WeatherBloc>().add(GetWeatherEvent());
    checkTemp();
    super.initState();
  }

  String celsiusToFahrenheit(double temp) {
    if(prefs?.getBool('degree') ?? true){
      return "${temp.round()}${Constants.tempInDegree}";
    }else{
      return '${((temp * 9.0 / 5.0) + 32.0).round()}${Constants.tempInFar}';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Weather App'),
        actions:  [
          GestureDetector(
            child: const Icon(Icons.settings),
            onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
                },
          ),
          const SizedBox(width: 10,),
          GestureDetector(
              child: const Icon(Icons.search),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>  SearchPage()));
            },),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext context, state) {
          if(state is WeatherInitial){
            return const Text('Loading . . .');
          }else if(state is WeatherLoaded){

            var cityData = state.weather['consolidated_weather'];
            var data = cityData[cityData.length - 1]['weather_state_name'];

            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      data == 'Light Cloud' ? Colors.blue
                      :data == 'Heavy Cloud' ? Colors.blueAccent
                      :data ==  'Showers' ? Colors.cyan
                          : Colors.yellow.shade700,
                      data == 'Light Cloud' ? Colors.blue.shade100
                          :data == 'Heavy Cloud' ? Colors.blueAccent.shade100
                          :data ==  'Showers' ? Colors.cyanAccent.shade100
                          : Colors.yellow.shade400,
                    ],
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    MyText(
                        text: state.weather['title'],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,),
                    MyText(
                        text: 'Updated ${DateFormat.jm().format(DateTime.now())}',
                    fontSize: 18,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              (data == 'Light Cloud') ? const Icon(Icons.cloud, size: 75,) :
                              (data == 'Showers') ? const Icon(Icons.grain, size: 75,) :
                              (data == 'Heavy Cloud') ? const Icon(Icons.ac_unit, size: 75,) :
                              const Icon(Icons.ac_unit, size: 50,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MyText(text: celsiusToFahrenheit(cityData[cityData.length - 1]['the_temp'])),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(text: 'max ${celsiusToFahrenheit(cityData[cityData.length - 1]['max_temp'
                              ])}'),
                              MyText(text: 'min ${celsiusToFahrenheit(cityData[cityData.length - 1]['min_temp'
                              ])}'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    MyText(text: cityData[cityData.length - 1]['weather_state_name'],
                    fontSize: 22,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/3,
                    ),

                  ],
                ),
              ),
            );
          }else if(state is WeatherError){
            return  Center(
              child: state.city == null ? const Text('Error is fetching data') :
              Text('No data available for ${state.city}'),
            );
          }
          return Container();
        },),
    );
  }
}