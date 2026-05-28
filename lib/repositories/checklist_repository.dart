import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:inspector_ro/models/checklist_model.dart';

class ChecklistRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // SALVAR CHECKLIST
  Future<void> salvarChecklist(ChecklistModel checklist) async {
    await firestore.collection('checklists').add(checklist.toMap());
  }

  // BUSCAR TODOS CHECKLISTS
  Future<List<ChecklistModel>> buscarChecklists() async {
    final snapshot = await firestore.collection('checklists').get();

    return snapshot.docs.map((doc) {
      return ChecklistModel.fromMap(doc.data());
    }).toList();
  }

  // BUSCAR CHECKLIST POR MATRÍCULA
  Future<List<ChecklistModel>> buscarPorMatricula(String matricula) async {
    final snapshot = await firestore
        .collection('checklists')
        .where('matricula', isEqualTo: matricula)
        .get();

    return snapshot.docs.map((doc) {
      return ChecklistModel.fromMap(doc.data());
    }).toList();
  }

  // BUSCAR CHECKLIST DA EMPILHADEIRA
  Future<List<ChecklistModel>> buscarPorEmpilhadeira(String prefixo) async {
    final snapshot = await firestore
        .collection('checklists')
        .where('prefixo', isEqualTo: prefixo)
        .get();

    return snapshot.docs.map((doc) {
      return ChecklistModel.fromMap(doc.data());
    }).toList();
  }

  // CHECKLIST ABERTO
  Future<bool> operadorPossuiChecklistAberto(String operadorId) async {
    final snapshot = await firestore
        .collection('checklists')
        .where('operadorId', isEqualTo: operadorId)
        .where('finalizado', isEqualTo: false)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // FINALIZAR CHECKLIST
  Future<void> finalizarChecklist(String checklistId) async {
    await firestore.collection('checklists').doc(checklistId).update({
      'finalizado': true,
    });
  }
}
