import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/models/forklift_model.dart';
import 'package:inspector_ro/pages/checklist.dart';
import 'package:inspector_ro/pages/teste.dart';
import 'package:inspector_ro/repositories/empilhadeira_repository.dart';

class ListForklift extends StatefulWidget {
  const ListForklift({super.key});

  @override
  State<ListForklift> createState() => _ListForkliftState();
}

class _ListForkliftState extends State<ListForklift> {
  List<ForkliftModel> listForklift = [];

  bool isLoading = true;
  double progress = 0;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final repository = EmpilhadeiraRepository();

  @override
  void initState() {
    super.initState();

    startLoading();
    queryFarebase();
  }

  // LOADING ANIMADO
  void startLoading() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 80));

      if (progress < 0.9) {
        setState(() {
          progress += 0.02;
        });
        return true;
      }

      return false;
    });
  }

  // BUSCAR FIREBASE
  queryFarebase() async {
    try {
      List<ForkliftModel> temp = [];

      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('empilhadeiras')
          .get();

      for (var doc in snapshot.docs) {
        try {
          temp.add(ForkliftModel.fromMap(doc.data()));
        } catch (e) {
          debugPrint('Erro ao converter documento: $e');
        }
      }

      // COMPLETA O PROGRESSO
      setState(() {
        listForklift = temp;
        progress = 1;
      });

      // ESPERA UM POUCO PRA MOSTRAR 100%
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        isLoading = false;
      });
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
  }

  // queryFarebase() async {
  //   try {
  //     final temp = await repository.buscarEmpilhadeiras();

  //     setState(() {
  //       listForklift = temp;
  //       progress = 1;
  //     });

  //     await Future.delayed(const Duration(milliseconds: 500));

  //     setState(() {
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // TELA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray1,
      drawer: Drawer(child: MenuDrawer()),

      appBar: AppBar(
        backgroundColor: AppColors.gray1,

        //actions: [TextField()],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TITLE
            Row(
              children: [
                Text(
                  'Lista',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: AppColors.gray6,
                  ),
                ),
                Text(
                  'Maquinas',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
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

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              // =========================
              // LOADING
              // =========================
              if (isLoading)
                buildLoading()
              // =========================
              // LISTA
              // =========================
              else
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 200,

                            child: TextFormField(
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.gray1,
                              decoration: InputDecoration(
                                hintText: 'Prefixo',
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,

                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.gray0,

                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppColors.gray1,

                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: AppColors.primary1,

                                  size: 30,
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'lufga',
                                color: AppColors.gray4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listForklift.length,

                          itemBuilder: (BuildContext context, int index) {
                            ForkliftModel forklift = listForklift[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),

                              child: Center(
                                child: GestureDetector(
                                  // NAVEGAÇÃO AQUI
                                  onTap: () async {
                                    if (forklift.estadoOperacional ==
                                        'Em Operação') {
                                      print('Em operção');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => testeScrin(),
                                        ),
                                      );
                                    } else {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChecklistForklift(
                                                empilhadeira: forklift,
                                              ),
                                        ),
                                      );
                                      setState(() {
                                        listForklift.clear();
                                        isLoading = true;
                                      });

                                      await queryFarebase();
                                    }

                                    setState(() {
                                      listForklift.clear();
                                      isLoading = true;
                                    });

                                    await queryFarebase();
                                  },

                                  child: SizedBox(
                                    width: double.infinity,

                                    height: 110, // altura
                                    child: Stack(
                                      children: [
                                        // CARD
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 1,
                                            bottom: 1,
                                            right: 1,
                                            top: 1,
                                          ),

                                          child: Container(
                                            width: double.infinity,

                                            height: 140,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.primary,
                                                width:
                                                    1, // A espessura da linha (ajuste conforme precisar)
                                              ),
                                              color: AppColors.primary2,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.all(10),

                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,

                                                      children: [
                                                        // DADOS
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,

                                                                children: [
                                                                  // PREFIXO
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),

                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,

                                                                        children: [
                                                                          Text(
                                                                            'Prefixo:',
                                                                            style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: AppColors.gray5,
                                                                            ),
                                                                          ),

                                                                          Text(
                                                                            forklift.prefixo.toString(),

                                                                            style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColors.primaryText,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 12,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                    child:
                                                                        VerticalDivider(),
                                                                  ),

                                                                  const SizedBox(
                                                                    width: 12,
                                                                  ),
                                                                  // FROTA
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),

                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,

                                                                        children: [
                                                                          Text(
                                                                            'Frota:',
                                                                            style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: AppColors.gray5,
                                                                            ),
                                                                          ),

                                                                          Text(
                                                                            forklift.frota.toString(),

                                                                            style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColors.primaryText,
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

                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        // KM
                                                        Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,

                                                              children: [
                                                                Text(
                                                                  'Horimetro:',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppColors
                                                                        .gray5,
                                                                  ),
                                                                ),

                                                                Text(
                                                                  forklift.km
                                                                      .toString(),

                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //SizedBox(height: 12),
                                                  // STATUS - IMAGENS
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // STATUS
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,

                                                        children: [
                                                          Row(
                                                            children: [
                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Disponível')
                                                                Icon(
                                                                  Icons
                                                                      .play_arrow_rounded,
                                                                  size: 18,
                                                                  color: AppColors
                                                                      .disponivel,
                                                                ),

                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Manutenção')
                                                                Icon(
                                                                  Icons
                                                                      .build_rounded,
                                                                  size: 14,
                                                                  color: AppColors
                                                                      .manutencao,
                                                                ),

                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Em Operação')
                                                                Icon(
                                                                  Icons
                                                                      .check_rounded,
                                                                  size: 18,
                                                                  color: AppColors
                                                                      .emOperacao,
                                                                ),

                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              // EM OPERAÇÃO
                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Em Operação')
                                                                Text(
                                                                  forklift
                                                                      .estadoOperacional
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .emOperacao,
                                                                  ),
                                                                ),
                                                              // EM MANUTENÇÃO
                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Manutenção')
                                                                Text(
                                                                  forklift
                                                                      .estadoOperacional
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .manutencao,
                                                                  ),
                                                                ),

                                                              // DISPONIVEL
                                                              if (forklift
                                                                      .estadoOperacional ==
                                                                  'Disponível')
                                                                Text(
                                                                  forklift
                                                                      .estadoOperacional
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .disponivel,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      if (forklift
                                                              .estadoOperacional ==
                                                          'Disponível')
                                                        Expanded(
                                                          child: Image.asset(
                                                            'image/PAGE-HOME-ICONS [Recuperado]_Prancheta 1.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      if (forklift
                                                              .estadoOperacional ==
                                                          'Manutenção')
                                                        Expanded(
                                                          child: Image.asset(
                                                            'image/PAGE-HOME-ICONS [Recuperado]_Prancheta 1.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      if (forklift
                                                              .estadoOperacional ==
                                                          'Em Operação')
                                                        Expanded(
                                                          child: Image.asset(
                                                            'image/user-blue.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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

  // =========================
  // WIDGET LOADING
  // =========================
  Widget buildLoading() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset('image/forklift.png', width: 140),

            const SizedBox(height: 20),

            RichText(
              text: TextSpan(
                text: 'Fork',
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Lufga',
                ),
                children: [
                  TextSpan(
                    text: 'Lift',
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Lufga',
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Preparando sistema...',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 220,

              child: LinearProgressIndicator(
                color: AppColors.primary,
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
