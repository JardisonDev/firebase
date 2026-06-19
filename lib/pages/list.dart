import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/models/forklift_model.dart';
import 'package:inspector_ro/pages/checklist.dart';
import 'package:inspector_ro/pages/scanner_qr.dart';
import 'package:inspector_ro/pages/teste.dart';
import 'package:audioplayers/audioplayers.dart';

class listMaquinas extends StatefulWidget {
  const listMaquinas({super.key});

  @override
  State<listMaquinas> createState() => _listMaquinasState();
}

class _listMaquinasState extends State<listMaquinas> {
  late Stream<List<ForkliftModel>> forkliftsStream;

  final AudioPlayer audioPlayer = AudioPlayer();

  final TextEditingController pesquisaController = TextEditingController();

  String filtro = '';

  @override
  void initState() {
    super.initState();
    forkliftsStream = streamForklifts();
    startLoading();
  }

  Future<void> tocarSom() async {
    await audioPlayer.play(AssetSource('quick-win.mp3'));
  }

  Stream<List<ForkliftModel>> streamForklifts() {
    return FirebaseFirestore.instance
        .collection('empilhadeiras')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ForkliftModel.fromMap(doc.data());
          }).toList();
        });
  }

  double progress = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray1,
      drawer: Drawer(child: MenuDrawer()),
      appBar: AppBar(
        backgroundColor: AppColors.gray1,
        automaticallyImplyLeading: false, // Desativa o menu padrão
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 30,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const Text(
                    'Lista',

                    style: TextStyle(
                      fontFamily: 'Lufga',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Empilhadeira',

                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Lufga',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
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

      body: StreamBuilder<List<ForkliftModel>>(
        stream: forkliftsStream,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoading();
          }

          // Erro
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          // Sem dados
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma empilhadeira encontrada'));
          }

          final listForklift = snapshot.data!;
          final maquinasFiltradas = listForklift.where((forklift) {
            return forklift.prefixo.toString().toLowerCase().contains(
              filtro.toLowerCase(),
            );
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    // BOTÃO SCANER
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            await tocarSom();
                            // ABRIR LEITOR QR FUTURAMENTE
                            // final resultado = await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => ScannerQrPage(),
                            //   ),
                            // );

                            // if (resultado != null) {
                            //   pesquisaController.text = resultado;

                            //   setState(() {
                            //     filtro = resultado;
                            //   });
                            // }
                          },
                          child: const Center(
                            child: Icon(
                              Icons.qr_code_rounded,
                              size: 24,
                              color: AppColors.gray1,
                            ),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.qr_code_rounded),
                      //   iconSize: 24,
                      //   color: AppColors.gray1,
                      //   onPressed: () {
                      //     // Abrir leitor QR futuramente
                      //   },
                      // ),
                    ),

                    const SizedBox(width: 8),
                    // PRESQUISAR PREFIXO
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: pesquisaController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              filtro = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Prefixo',
                            filled: true,
                            fillColor: AppColors.gray1,
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.gray6,
                              size: 30,
                            ),
                            suffixIcon: filtro.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 30),
                                    onPressed: () {
                                      pesquisaController.clear();
                                      setState(() {
                                        filtro = '';
                                      });
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.gray3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // LISTA
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: maquinasFiltradas.length,
                  itemBuilder: (context, index) {
                    final forklift = maquinasFiltradas[index];

                    return Card(
                      color: AppColors.primary2,

                      //surfaceTintColor: AppColors.primary1,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: const Color(0xFFF7FDFF),
                              borderRadius: BorderRadius.circular(14),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(12),

                              child: GestureDetector(
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
                                        builder: (context) => ChecklistForklift(
                                          empilhadeira: forklift,
                                        ),
                                      ),
                                    );
                                    // setState(() {
                                    //   listForklift.clear();
                                    //   isLoading = true;
                                    // });

                                    //await queryFarebase();
                                  }

                                  // setState(() {
                                  //   listForklift.clear();
                                  //   isLoading = true;
                                  // });

                                  // await queryFarebase();
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // HEADER
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              forklift.estadoOperacional ==
                                                      'Em Operação'
                                                  ? 'Empilhadeira em Operação'
                                                  : forklift.estadoOperacional ==
                                                        'Manutenção'
                                                  ? 'Empilhadeira em Manutenção'
                                                  : forklift.estadoOperacional ==
                                                        'Disponível'
                                                  ? 'Empilhadeira Disponível'
                                                  : 'Status não informado',

                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),

                                            const SizedBox(width: 6),

                                            Container(
                                              width: 8,
                                              height: 8,

                                              decoration: BoxDecoration(
                                                color: Color(0xFF007A8D),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.play_arrow_rounded,
                                              size: 18,
                                              color: Color(0xFF007A8D),
                                            ),

                                            SizedBox(width: 4),

                                            Text(
                                              'Em Uso',

                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF007A8D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),

                                    // CONTEÚDO
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,

                                      children: [
                                        // INFORMAÇÕES
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,

                                            children: [
                                              // PREFIXO
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    'Prefixo:',

                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ),
                                                  ),

                                                  SizedBox(height: 2),

                                                  Text(
                                                    forklift.prefixo.toString(),

                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Container(
                                                width: 1,
                                                height: 32,
                                                color: Color(0xFFE5E7EB),
                                              ),

                                              // FROTA
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    'Frota:',

                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ),
                                                  ),

                                                  SizedBox(height: 2),

                                                  Text(
                                                    forklift.frota.toString(),

                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Container(
                                                width: 1,
                                                height: 32,
                                                color: Color(0xFFE5E7EB),
                                              ),

                                              // HORIMETRO
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    'Horímetro',

                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ),
                                                  ),

                                                  SizedBox(height: 2),
                                                  Text(
                                                    forklift.km.toString(),

                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 14),

                                        // IMAGEM
                                        if (forklift.estadoOperacional ==
                                            'Disponível')
                                          Image.asset(
                                            'image/disponivel.png',

                                            width: 65,
                                            height: 65,
                                          ),
                                        if (forklift.estadoOperacional ==
                                            'Manutenção')
                                          Image.asset(
                                            'image/manutencao.png',
                                            width: 65,
                                            height: 65,
                                          ),
                                        if (forklift.estadoOperacional ==
                                            'Em Operação')
                                          Image.asset(
                                            'image/user.png',
                                            width: 65,
                                            height: 65,
                                          ),
                                      ],
                                    ),

                                    const SizedBox(height: 14),

                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade300,
                                    ),

                                    const SizedBox(height: 12),

                                    // OPERADOR
                                    Row(
                                      children: [
                                        Container(
                                          width: 34,
                                          height: 34,

                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),

                                          child: const Icon(
                                            Icons.person,
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: const [
                                            Text(
                                              'Operador',

                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),

                                            SizedBox(height: 2),

                                            Text(
                                              'Carlos Eduardo',

                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // WIDGET LOADING
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
                text: 'Otrack',
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Lufga',
                ),
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
