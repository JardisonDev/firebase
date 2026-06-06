class ForkliftModel {
  final int prefixo;
  final int frota;
  final int km;
  final String estadoOperacional;
  final String uid_operador;

  ForkliftModel({
    required this.prefixo,
    required this.km,
    required this.frota,
    required this.uid_operador,
    required this.estadoOperacional,
  });

  factory ForkliftModel.fromMap(Map<String, dynamic> map) {
    return ForkliftModel(
      prefixo: (map['prefixo'] as num?)?.toInt() ?? 0,
      km: (map['km'] as num?)?.toInt() ?? 0,
      frota: (map['frota'] as num?)?.toInt() ?? 0,
      uid_operador: map['uid_operador'].toString(),
      estadoOperacional: map['estadoOperacional']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prefixo': prefixo,
      'km': km,
      'frota': frota,
      'estadoOperacional': estadoOperacional,
      'uid_operador': uid_operador,
    };
  }
}
