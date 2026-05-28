class ForkliftModel {
  final int prefixo;
  final int frota;

  final String estadoOperacional;

  final int km;

  final String? operador;

  ForkliftModel({
    required this.prefixo,
    required this.km,
    required this.frota,
    required this.operador,
    required this.estadoOperacional,
  });

  // FIREBASE -> MODEL
  ForkliftModel.fromMap(Map<String, dynamic> map)
    : prefixo = map['prefixo']?.toInt(),
      operador = map['operador'],
      km = map['km']?.toInt(),
      frota = map['frota']?.toInt(),
      estadoOperacional = map['Estado Operacional'].toString();

  // MODEL -> FIREBASE
  Map<String, dynamic> toMap() {
    return {
      'prefixo': prefixo,
      'km': km,
      'frota': frota,
      'estadoOperacional': estadoOperacional,
      'operador': operador,
    };
  }
}
