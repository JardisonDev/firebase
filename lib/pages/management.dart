import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/pages/List_Forklift.dart';
import 'package:inspector_ro/repositories/forklift.dart';
//import 'package:inspector_ro/service/home_screen.dart';
//import 'package:firebase_core/firebase_core.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  // Estanciar Firebase.
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Lista das Empilhadeiras.
  List<Forklift> listForklift = [];

  String _emailLogado = '';

  // Recupear usuario logado.
  Future _recuperarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? userLogado = auth.currentUser;
    if (userLogado != null) {
      setState(() {
        _emailLogado = userLogado.email ?? 'E-mail não encontrado';
      });
    }
  }

  @override
  void initState() {
    _recuperarUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Gestão',
            style: TextStyle(
              fontFamily: 'Lufga',
              color: Color(0xff212121),
              fontSize: 25,
            ),
            children: [
              TextSpan(
                text: 'Operacional',
                style: TextStyle(
                  fontFamily: 'Lufga',
                  color: Color(0xffd1655b),
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(child: MenuDrawer()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 22),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // 1. CAMADA DE FUNDO (Sombra/Borda inferior)
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.orangePeel,
                      child: Container(
                        width: double.infinity,
                        height: 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    // 2. CAMADA DA FRENTE (Conteúdo principal)
                    Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Separa o topo da base
                          children: [
                            // PRIMEIRA ROW: Cabeçalho do Card
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Novo Checklist',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                      Text(
                                        'Iniciar inspeção de rotina do equipamento',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // SEGUNDA ROW: Rodapé do Card (Ícone e Ação)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment
                                  .end, // Alinha o botão e o ícone na base
                              children: [
                                const Icon(
                                  Icons.forklift,
                                  color: AppColors.orangePeel,
                                  size: 45,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ListForklift(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.orangePeel,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Iniciar',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: AppColors.secondary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // 1. CAMADA DE FUNDO (Sombra/Borda)
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.secondary,
                      child: Container(
                        width: double.infinity,
                        height: 135,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    // 2. CAMADA DA FRENTE (Conteúdo)
                    Container(
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Joga uma Row para o topo e outra para o fundo
                          children: [
                            // PRIMEIRA ROW: Textos
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Registrar Abastecimentos',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      Text(
                                        'Clique para registrar o combustível consumido',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // SEGUNDA ROW: Ícone e Botão
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //alignment: Alignment.bottomCenter,
                              children: [
                                const Icon(
                                  Icons.local_gas_station,
                                  color: AppColors.secondary,
                                  size: 45,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Registrar',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: AppColors.primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.all(16)),
                Text(_emailLogado),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Pergar dados do Firebase.
  // _refresh() async {
  //   List<Forklift> temp = [];

  //   QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
  //       .collection('empilhadeiras')
  //       .get();

  //   for (var doc in snapshot.docs) {
  //     temp.add(Forklift.fromMap(doc.data()));
  //   }
  //   setState(() {
  //     listForklift = temp;
  //   });
  // }
}
