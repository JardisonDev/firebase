import 'package:inspector_ro/models/checklist_item_model.dart';

class ChecklistItemsData {
  static List<ChecklistItemModel> itensPadrao() {
    return [
      ChecklistItemModel(
        id: 'freios',

        titulo: 'Freio',

        descricao: 'Funcionamentos e eficiência',
      ),

      ChecklistItemModel(
        id: 'direcao',

        titulo: 'Direção',

        descricao: 'Sistema de direção',
      ),

      ChecklistItemModel(
        id: 'retrovisores',

        titulo: 'Retrovisores',

        descricao: 'Ajustes e limpeza',
      ),

      ChecklistItemModel(
        id: 'motor',

        titulo: 'Funcionamento motor',

        descricao: 'Capacidade e ruídos',
      ),

      ChecklistItemModel(
        id: 'pneusDianteiros',

        titulo: 'Pneus dianteiros',

        descricao: 'Estado e pressão',
      ),

      ChecklistItemModel(
        id: 'pneusTraseiros',

        titulo: 'Pneus traseiros',

        descricao: 'Estado e pressão',
      ),

      ChecklistItemModel(
        id: 'assento',

        titulo: 'Assento operador',

        descricao: 'Fixação e ajustes',
      ),

      ChecklistItemModel(
        id: 'teto',

        titulo: 'Proteção do teto',

        descricao: 'Estrutura e fixação',
      ),

      ChecklistItemModel(
        id: 'freio',

        titulo: 'Freio Estacionamento',

        descricao: 'Funcional',
      ),
      ChecklistItemModel(
        id: 'painel',

        titulo: 'Painel',

        descricao: 'Indicadores ativos',
      ),
      ChecklistItemModel(
        id: 'botija',

        titulo: 'Botija de GLP',

        descricao: 'Fixada e vedada',
      ),
      ChecklistItemModel(
        id: 'sinalLuminoso',

        titulo: 'Sinal Luminoso',

        descricao: 'Funcionando',
      ),
      ChecklistItemModel(
        id: 'sinalSonoro',
        titulo: 'Sinal Sonoro',
        descricao: 'Funcionando',
      ),
      ChecklistItemModel(
        id: 'garfoClap',
        titulo: 'Garfo ou Clap',
        descricao: 'Fixação e desgaste OK',
      ),
      ChecklistItemModel(
        id: 'levantamentoTorre',
        titulo: 'Levantamento de Torre',
        descricao: 'Movimento normal',
      ),
      ChecklistItemModel(
        id: 'inclinaçãoTorre',
        titulo: 'Inclinação da torre',
        descricao: 'Funcionando',
      ),
      ChecklistItemModel(
        id: 'corrente',
        titulo: 'Corrente',
        descricao: 'Tensão adequada',
      ),
      ChecklistItemModel(
        id: 'nivelRadiador',
        titulo: 'Nivél água do Radiador',
        descricao: 'Nível adequado',
      ),
      ChecklistItemModel(
        id: 'nivelMotor',
        titulo: 'Nivél do óleo do Motor',
        descricao: 'Nível adequado',
      ),
      ChecklistItemModel(
        id: 'bateriaCarga',
        titulo: 'Carga da Bateria',
        descricao: 'Carga suficiente',
      ),
      ChecklistItemModel(
        id: 'purificadorAr',
        titulo: 'Purificador de Ar',
        descricao: 'Limpo',
      ),
      ChecklistItemModel(
        id: 'nívelHidráulico',
        titulo: 'Nível do óleo Hidráulico',
        descricao: 'Nível adequado',
      ),
      ChecklistItemModel(
        id: 'cintosegurança',
        titulo: 'Cinto de segurança',
        descricao: 'Fixado',
      ),
      ChecklistItemModel(
        id: 'extintorIncêndio',
        titulo: 'Extintor de incêndio',
        descricao: 'Fixado',
      ),
      ChecklistItemModel(
        id: 'equipVazamento?',
        titulo: 'Equip. sem vazamento?',
        descricao: 'Fixado',
      ),
    ];
  }
}
