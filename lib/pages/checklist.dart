import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/constants/checklist_items_data.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/models/checklist_item_model.dart';
import 'package:inspector_ro/models/forklift_model.dart';
import 'package:inspector_ro/widgets/checklist_item_tile.dart';
import 'package:inspector_ro/controllers/checklist_controller.dart';
import 'package:inspector_ro/models/checklist_model.dart';

//import 'package:inspector_ro/models/checklist_model.dart';

class ChecklistForklift extends StatefulWidget {
  final ForkliftModel empilhadeira;
  const ChecklistForklift({super.key, required this.empilhadeira});

  @override
  State<ChecklistForklift> createState() => _ChecklistForkliftState();
}

bool atencao = false;
late List<ChecklistItemModel> itens;

class _ChecklistForkliftState extends State<ChecklistForklift> {
  Future<void> salvarChecklist() async {
    String resultado = controller.resultadoChecklist(itens);

    ChecklistModel checklist = ChecklistModel(
      operadorId: 'UID_USUARIO',
      operadorNome: 'NOME_USUARIO',
      matricula: 'MATRICULA_USUARIO',
      empilhadeiraId: widget.empilhadeira.prefixo,
      prefixo: widget.empilhadeira.prefixo,
      frota: widget.empilhadeira.frota,
      horimetro: widget.empilhadeira.km,
      resultado: resultado,
      itens: itens,
      createdAt: DateTime.now(),
      finalizado: true,
    );

    await controller.salvarChecklist(checklist: checklist);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checklist finalizado com sucesso'),
        duration: Duration(seconds: 2),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    itens = ChecklistItemsData.itensPadrao();
  }

  final ChecklistController controller = ChecklistController();
  final TextEditingController horimetroController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(child: MenuDrawer()),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TITLE
              Row(
                children: [
                  Text(
                    'Check',
                    style: TextStyle(
                      fontFamily: 'Lufga',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Text(
                    'list',
                    style: TextStyle(
                      fontFamily: 'Lufga',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              // BOTÃO VOLTAR
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.gray6,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // DADOS DA EMPILHADEIRA
                    Container(
                      padding: const EdgeInsets.all(6),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12),

                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray0.withOpacity(0.1),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                // STATUS
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      221,
                                      240,
                                      203,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),

                                  child: Text(
                                    'Disponivel',

                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.disponivel,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // PREFIXO - FROTA - HORIMETRO
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // PREFIXO
                                          Row(
                                            children: [
                                              // ICON
                                              Icon(
                                                Icons.confirmation_num,
                                                size: 22,
                                                color: AppColors.gray5,
                                              ),
                                              SizedBox(width: 6),
                                              // PREFIXO
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Prefixo:',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.empilhadeira.prefixo
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: VerticalDivider(),
                                          ),

                                          // FROTA
                                          Row(
                                            children: [
                                              // ICON
                                              Icon(
                                                Icons.confirmation_num_outlined,
                                                size: 22,
                                                color: AppColors.gray5,
                                              ),
                                              SizedBox(width: 6),

                                              // FROTA
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Frota:',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.empilhadeira.frota
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: VerticalDivider(),
                                          ),

                                          // HORIMETRO
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.speed_rounded,
                                                size: 22,
                                                color: AppColors.gray5,
                                              ),
                                              SizedBox(width: 6),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Horímetro:',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.empilhadeira.km
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontSize: 14,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    Expanded(
                      child: ListView.builder(
                        // TAMANHO LIST => itens
                        itemCount: itens.length,

                        itemBuilder: (context, index) {
                          final item = itens[index];

                          return ChecklistItemTile(
                            item: item,

                            onChanged: (status) {
                              setState(() {
                                item.status = status;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          salvarChecklist();
                        },
                        child: const Text('Finalizar Checklist'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
