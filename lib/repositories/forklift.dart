class Forklift {
  int? prefixo;
  int? km;
  int? frota;
  String? estadoOperacional;

  Forklift({this.prefixo, this.km, this.frota, this.estadoOperacional});

  // Transformar o JSON do Firebase em um objeto Forklift
  Forklift.fromMap(Map<String, dynamic> map)
    : prefixo = map['prefixo']?.toInt(),
      km = map['km']?.toInt(),
      frota = map['frota']?.toInt(),
      estadoOperacional = map['Estado Operacional']?.toString();

  Map<String, dynamic> toMap() {
    return {
      'prefixo': prefixo,
      'km': km,
      'frota': frota,
      'estadoOperacional': estadoOperacional,
    };
  }
}
