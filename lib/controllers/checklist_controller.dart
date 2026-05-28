import 'package:inspector_ro/models/checklist_item_model.dart';

import 'package:inspector_ro/models/checklist_model.dart';

import 'package:inspector_ro/repositories/checklist_repository.dart';

import 'package:inspector_ro/repositories/empilhadeira_repository.dart';

class ChecklistController {
  final ChecklistRepository checklistRepository = ChecklistRepository();

  final EmpilhadeiraRepository empilhadeiraRepository =
      EmpilhadeiraRepository();

  // VERIFICAR ATENÇÃO
  bool checklistPossuiAtencao(List<ChecklistItemModel> itens) {
    return itens.any((item) => item.estaAtencao);
  }

  // RESULTADO FINAL
  String resultadoChecklist(List<ChecklistItemModel> itens) {
    return itens.any((item) => item.estaAtencao) ? 'atencao' : 'ok';
  }

  // SALVAR CHECKLIST
  Future<void> salvarChecklist({required ChecklistModel checklist}) async {
    // SALVA CHECKLIST
    await checklistRepository.salvarChecklist(checklist);

    // POSSUI ATENÇÃO?
    bool possuiAtencao = checklistPossuiAtencao(checklist.itens);

    // ATUALIZA STATUS MÁQUINA
    await empilhadeiraRepository.atualizarStatus(
      prefixo: checklist.prefixo,

      status: possuiAtencao ? 'Manutenção' : 'Em Operação',
    );
  }

  // VERIFICAR CHECKLIST ABERTO
  Future<bool> operadorPodeIniciarChecklist(String operadorId) async {
    bool possuiChecklist = await checklistRepository
        .operadorPossuiChecklistAberto(operadorId);

    return !possuiChecklist;
  }

  // FINALIZAR CHECKLIST
  Future<void> finalizarChecklist({
    required String checklistId,

    required String prefixo,
  }) async {
    // FINALIZA CHECKLIST
    await checklistRepository.finalizarChecklist(checklistId);

    // LIBERA EMPILHADEIRA
    await empilhadeiraRepository.liberarEmpilhadeira(prefixo);
  }
}
