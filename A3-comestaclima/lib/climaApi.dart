// ignore_for_file: file_names

import 'dart:convert';

import 'package:a3_appclima/Clima.dart';
import 'package:http/http.dart' as http;

class ClimaApi {
  Future<Clima> fecthClima(cidade) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=f25a149e08d00e767222c90ac55a9d84';
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body);
    final clima = Clima.fromJson(body);
    return clima;
  }
}
