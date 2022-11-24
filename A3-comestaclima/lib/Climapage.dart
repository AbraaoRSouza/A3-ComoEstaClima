// ignore_for_file: file_names

import 'package:a3_appclima/Clima.dart';
import 'package:a3_appclima/assets/ClimaIcons.dart';
import 'package:a3_appclima/climaApi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaginaPrincipal extends StatefulWidget {
  final String cidade;
  const PaginaPrincipal({super.key, required this.cidade});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  ClimaApi api = ClimaApi();
  Clima clima = Clima();
  @override
  void initState() {
    super.initState();
    api.fecthClima(widget.cidade);
  }

  Future<Clima> getDados() async {
    clima = await api.fecthClima(widget.cidade);
    return clima;
  }

  String? cidade;
  String? pais;
  double? temperatura;
  double? tempMax;
  double? tempMin;
  double? vento;
  double? sensacaoTermica;
  int? humidade;
  String caminhoImagem = '';
  String msgTemperatura = '';
  String msgClima = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Como está o clima"),
          backgroundColor: const Color.fromARGB(255, 6, 43, 52),
        ),
        body: FutureBuilder(
            future: getDados(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                cidade = clima.cidade;
                pais = clima.pais;
                temperatura = (clima.temperatura! - 273.15).roundToDouble();
                tempMax = (clima.tempMax! - 273.15).roundToDouble();
                tempMin = (clima.tempMin! - 273.15).roundToDouble();
                vento = double.parse((clima.vento! * 3.6).toStringAsFixed(2));
                sensacaoTermica =
                    (clima.sensacaoTermica! - 273.15).roundToDouble();
                humidade = clima.humidade;
                if (clima.weather == 'Rain') {
                  caminhoImagem = 'assets/images/Chuva.png';
                  msgClima =
                      'Leve um guarda-chuva ou capa de chuva, pois etá chovendo';
                } else if (clima.weather == 'Thunderstorm') {
                  caminhoImagem = 'assets/images/Tempestade.png';
                  msgClima =
                      'Leve um guarda-chuva ou capa de chuva, pois etá chovendo muito!!!';
                } else if (clima.weather == 'Snow') {
                  caminhoImagem = 'assets/images/Nevando.png';
                  msgClima = 'Se agasalhe pois está frio';
                }
                if (clima.descricao == 'scattered clouds' ||
                    clima.descricao == 'broken clouds') {
                  caminhoImagem = 'assets/images/SolComNuvens.png';
                  msgClima = 'O dia está sem graça';
                } else if (clima.descricao == 'few clouds' ||
                    clima.weather == 'Clear') {
                  caminhoImagem = 'assets/images/Sol.png';
                  msgClima = 'Hoje o dia está bonito';
                } else if (clima.descricao == 'overcast clouds' ||
                    clima.weather == 'Mist') {
                  caminhoImagem = 'assets/images/Nublado.png';
                  msgClima = 'Hoje o dia etá feio, está nublado';
                }
                if (temperatura! <= 15) {
                  msgTemperatura = 'Leve uma blusa se for sair';
                } else if (temperatura! >= 33) {
                  msgTemperatura = 'Calor pra burro';
                } else {
                  msgTemperatura = 'Clima está agradavel';
                }
                showToastTemperatura();
                showToastClima();
                return Container(
                    color: const Color.fromARGB(255, 6, 43, 52),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(height: 15),
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 30),
                            Text(
                              'Cidade: $cidade - $pais',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 38),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset(caminhoImagem),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(ClimaIcons.termometro,
                                color: Colors.white, size: 21),
                            Text(' Temperatura: $temperatura°C',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 21))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(ClimaIcons.termometroTempMax,
                                color: Colors.white, size: 21),
                            Text(' Temp máxima: $tempMax / ',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 21)),
                            const Icon(ClimaIcons.termometroTempMin,
                                color: Colors.white, size: 21),
                            Text(' Temp minima: $tempMin',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 21)),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.thermostat_auto,
                                  color: Colors.white, size: 21),
                              Text(' Sensação Termica: $sensacaoTermica°C',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 21)),
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.water_drop,
                                color: Colors.blueAccent, size: 21),
                            Text('Humidade: $humidade%',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 21)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(ClimaIcons.vento,
                                color: Colors.white, size: 21),
                            Text(' Vento: $vento km/h',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 21)),
                          ],
                        )
                      ],
                    ));
              }
              return Container(
                color: const Color.fromARGB(255, 6, 43, 52),
              );
            }));
  }

  void showToastTemperatura() {
    Fluttertoast.showToast(
      msg: msgTemperatura,
      fontSize: 16,
      textColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
    );
  }

  void showToastClima() {
    Fluttertoast.showToast(
      msg: msgClima,
      fontSize: 16,
      textColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
    );
  }
}
