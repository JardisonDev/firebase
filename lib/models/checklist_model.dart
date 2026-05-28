import 'package:inspector_ro/models/checklist_item_model.dart';

class ChecklistModel {
  final String operadorId;

  final String operadorNome;

  final String matricula;

  final int empilhadeiraId;

  final int prefixo;

  final int frota;

  final int horimetro;

  final String resultado;

  final List<ChecklistItemModel> itens;

  final String observacao;

  final String assinatura;

  final bool finalizado;

  final DateTime createdAt;

  ChecklistModel({
    required this.operadorId,

    required this.operadorNome,

    required this.matricula,

    required this.empilhadeiraId,

    required this.prefixo,

    required this.frota,

    required this.horimetro,

    required this.resultado,

    required this.itens,

    required this.createdAt,

    this.observacao = '',

    this.assinatura = '',

    required this.finalizado,
  });

  // FIREBASE -> MODEL
  factory ChecklistModel.fromMap(Map<String, dynamic> map) {
    return ChecklistModel(
      operadorId: map['operadorId'] ?? '',

      operadorNome: map['operadorNome'] ?? '',

      matricula: map['matricula'] ?? '',
      empilhadeiraId: map['empilhadeiraId'] ?? '',

      prefixo: map['prefixo'] ?? '',

      frota: map['frota'] ?? '',

      horimetro: map['horimetro'] ?? 0,

      resultado: map['resultado'] ?? '',

      observacao: map['observacao'] ?? '',

      assinatura: map['assinatura'] ?? '',

      finalizado: map['finalizado'] ?? '',

      createdAt: DateTime.parse(map['createdAt']),

      itens: (map['itens'] as List)
          .map((item) => ChecklistItemModel.fromMap(item))
          .toList(),
    );
  }

  // MODEL -> FIREBASE
  Map<String, dynamic> toMap() {
    return {
      'operadorId': operadorId,

      'operadorNome': operadorNome,

      'empilhadeiraId': empilhadeiraId,

      'prefixo': prefixo,

      'frota': frota,

      'horimetro': horimetro,

      'resultado': resultado,

      'observacao': observacao,

      'assinatura': assinatura,

      'finalizado': finalizado,

      'createdAt': createdAt.toIso8601String(),

      'itens': itens.map((item) => item.toMap()).toList(),
    };
  }
}
