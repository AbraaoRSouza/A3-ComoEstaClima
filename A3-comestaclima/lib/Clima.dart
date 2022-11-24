// ignore_for_file: file_names
class Clima {
  String? cidade;
  String? pais;
  double? temperatura;
  double? tempMax;
  double? tempMin;
  String? weather;
  String? descricao;
  double? sensacaoTermica;
  double? vento;
  int? humidade;

  Clima(
      {this.cidade,
      this.pais,
      this.temperatura,
      this.tempMax,
      this.tempMin,
      this.weather,
      this.descricao,
      this.humidade,
      this.sensacaoTermica,
      this.vento});

  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
        cidade: json["name"],
        pais: json["sys"]["country"],
        temperatura: json["main"]["temp"],
        tempMax: json["main"]["temp_max"],
        tempMin: json["main"]["temp_min"],
        weather: json["weather"][0]["main"],
        descricao: json["weather"][0]["description"],
        sensacaoTermica: json["main"]["feels_like"],
        vento: json["wind"]["speed"],
        humidade: json["main"]["humidity"]);
  }
}
