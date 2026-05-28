class ChecklistItemModel {
  final String id;

  final String titulo;

  final String descricao;

  String status;

  ChecklistItemModel({
    required this.id,

    required this.titulo,

    required this.descricao,

    this.status = 'ok',
  });

  bool get estaOk => status == 'ok';

  bool get estaAtencao => status == 'atencao';

  factory ChecklistItemModel.fromMap(Map<String, dynamic> map) {
    return ChecklistItemModel(
      id: map['id'] ?? '',

      titulo: map['titulo'] ?? '',

      descricao: map['descricao'] ?? '',

      status: map['status'] ?? 'ok',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'titulo': titulo,

      'descricao': descricao,

      'status': status,
    };
  }
}
