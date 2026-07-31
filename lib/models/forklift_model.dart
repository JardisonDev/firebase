class ForkliftModel {
  final int iD;
  final int prefixo;
  final int frota;
  final int km;
  final String estadoOperacional;
  final String iD_operador;
  final String operador;

  ForkliftModel({
    required this.iD,
    required this.prefixo,
    required this.km,
    required this.frota,
    required this.iD_operador,
    required this.estadoOperacional,
    required this.operador,
  });

  factory ForkliftModel.fromMap(Map<String, dynamic> map) {
    return ForkliftModel(
      iD: (map['iD'] as num?)?.toInt() ?? 0,
      prefixo: (map['prefixo'] as num?)?.toInt() ?? 0,
      km: (map['km'] as num?)?.toInt() ?? 0,
      frota: (map['frota'] as num?)?.toInt() ?? 0,
      iD_operador: map['uid_operador'].toString(),
      estadoOperacional: map['estadoOperacional']?.toString() ?? '',
      operador: map['operador']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iD': iD,
      'prefixo': prefixo,
      'km': km,
      'frota': frota,
      'estadoOperacional': estadoOperacional,
      'uid_operador': iD_operador,
      'operador': operador,
    };
  }
}
