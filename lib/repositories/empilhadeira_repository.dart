import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inspector_ro/models/forklift_model.dart';

class EmpilhadeiraRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //BUSCAR TODAS EMPILHADEIRAS
  Future<List<ForkliftModel>> buscarEmpilhadeiras() async {
    final snapshot = await firestore.collection('empilhadeiras').get();

    return snapshot.docs.map((doc) {
      return ForkliftModel.fromMap(doc.data());
    }).toList();
  }

  // Future<List<ForkliftModel>> buscarEmpilhadeiras() async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('empilhadeiras')
  //       .limit(1)
  //       .get();

  //   print('QTD DOCS: ${snapshot.docs.length}');

  //   for (var doc in snapshot.docs) {
  //     print('ID: ${doc.id}');
  //     print(doc.data());
  //   }

  //   return [];
  // }

  // BUSCAR POR PREFIXO
  Future<ForkliftModel?> buscarPorPrefixo(String prefixo) async {
    final snapshot = await firestore
        .collection('empilhadeiras')
        .doc(prefixo)
        .get();

    if (!snapshot.exists) {
      return null;
    }
    return ForkliftModel.fromMap(snapshot.data()!);
  }

  // ATUALIZAR STATUS
  Future<void> atualizarStatus({
    required int prefixo,
    required String status,
  }) async {
    await firestore.collection('empilhadeiras').doc(prefixo.toString()).update({
      'estadoOperacional': status,
    });
  }

  // ATRIBUIR OPERADOR
  Future<void> atribuirOperador({
    required String prefixo,
    required String operadorId,
    required String operadorNome,
  }) async {
    await firestore.collection('empilhadeiras').doc(prefixo).update({
      'operadorId': operadorId,
      'operador': operadorNome,

      'estadoOperacional': 'Em Operação',
    });
  }

  // LIBERAR EMPILHADEIRA
  Future<void> liberarEmpilhadeira(String prefixo) async {
    await firestore.collection('empilhadeiras').doc(prefixo).update({
      'operadorId': '',
      'operador': '',

      'estadoOperacional': 'Disponível',
    });
  }

  // FILTRAR DISPONÍVEIS
  Future<List<ForkliftModel>> buscarDisponiveis() async {
    final snapshot = await firestore
        .collection('empilhadeiras')
        .where('estadoOperacional', isEqualTo: 'Disponível')
        .get();

    return snapshot.docs.map((doc) {
      return ForkliftModel.fromMap(doc.data());
    }).toList();
  }
}
