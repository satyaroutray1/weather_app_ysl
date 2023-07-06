import 'dart:convert';
import 'package:http/http.dart' as Http;
import '../models/weather.dart';
import 'json_structure.dart';

class Repo{

  Future getApiData() async{
    return weatherJsonData;
  }
}
