import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool? isSwitched;
  SharedPreferences? prefs;

  checkTemp() async{
    prefs = await SharedPreferences.getInstance();
    isSwitched = prefs?.getBool('degree') ?? true;

  }
  void toggleSwitch(bool value) {

    if(isSwitched == false) {
      setState(() {
        isSwitched = true;
        prefs?.setBool('degree', true);
        context.read<WeatherBloc>().add(GetWeatherEvent());
      });
    } else {
      setState(() {
        isSwitched = false;
        prefs?.setBool('degree', false);
        context.read<WeatherBloc>().add(GetWeatherEvent());
      });
    }
  }
  @override
  void initState() {
    checkTemp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Temperature units',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
              const Text('Use metric measurements for\ntemperature units'),
              Switch(
                  onChanged: toggleSwitch,
                  value: prefs?.getBool('degree') ?? true,
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
              )
            ],)
          ],
        ),
      ),
    );
  }
}
