import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';

import 'package:inspector_ro/models/forklift_model.dart';
import 'package:inspector_ro/pages/list_forklift.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  // Estanciar Firebase.
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Lista das Empilhadeiras.
  List<ForkliftModel> listForklift = [];

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
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        title: RichText(
          text: TextSpan(
            text: 'Gestão',
            style: TextStyle(
              fontFamily: 'Lufga',
              color: AppColors.gray1,
              fontSize: 25,
            ),
            children: [
              TextSpan(
                text: 'Operacional',
                style: TextStyle(
                  fontFamily: 'Lufga',
                  color: AppColors.primary,
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
                      color: AppColors.primary,
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
                        color: AppColors.primaryText,
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
                                  color: AppColors.primary,
                                  size: 45,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
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
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Iniciar',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: AppColors.primaryText,
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
                      color: AppColors.primaryText,
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
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                      Text(
                                        'Clique para registrar o combustível consumido',
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

                            // SEGUNDA ROW: Ícone e Botão
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //alignment: Alignment.bottomCenter,
                              children: [
                                const Icon(
                                  Icons.local_gas_station,
                                  color: AppColors.primaryText,
                                  size: 45,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryText,
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
                SizedBox(height: 12),
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

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Empilhadeira em Uso',

                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(width: 6),

                                Container(
                                  width: 8,
                                  height: 8,

                                  decoration: const BoxDecoration(
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
                          crossAxisAlignment: CrossAxisAlignment.center,

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

                                    children: const [
                                      Text(
                                        'Prefixo',

                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(height: 2),

                                      Text(
                                        '23120008',

                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
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

                                    children: const [
                                      Text(
                                        'Frota',

                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(height: 2),

                                      Text(
                                        '424',

                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
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

                                    children: const [
                                      Text(
                                        'Horímetro',

                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(height: 2),

                                      Text(
                                        '5.240h',

                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 14),

                            // IMAGEM
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),

                              child: Image.asset(
                                'image/user-blue.png',

                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Divider(height: 1, color: Colors.grey.shade300),

                        const SizedBox(height: 12),

                        // OPERADOR
                        Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,

                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: const Icon(
                                Icons.person,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

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
                Padding(padding: EdgeInsets.all(16)),
                Text(_emailLogado),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
