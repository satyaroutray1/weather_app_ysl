import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_event.dart';

class SearchPage extends StatelessWidget {

  TextEditingController city = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: city,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'city',
                    hintText: 'Enter city',
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  context.read<WeatherBloc>().add(GetWeatherEvent(cityName: city.text.toLowerCase()));
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  color: Colors.blue[50],
                  padding: const EdgeInsets.all(20),
                    child: const Icon(Icons.search)),
              )
            ],
          )
        ],
      ),
    );
  }
}
