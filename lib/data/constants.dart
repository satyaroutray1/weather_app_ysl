import 'package:shared_preferences/shared_preferences.dart';

class Constants{
  static String tempInDegree = '°C';
  static String tempInFar = 'F';
  SharedPreferences? prefs;

  String celsiusToFahrenheit(double temp) {
    if(prefs?.getBool('degree') ?? true){
      return "${temp.round()}${Constants.tempInDegree}";
    }else{
      return '${((temp * 9.0 / 5.0) + 32.0).round()}${Constants.tempInFar}';
    }
  }
}