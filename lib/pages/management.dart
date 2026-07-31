import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';

import 'package:inspector_ro/models/forklift_model.dart';
import 'package:inspector_ro/pages/checklist.dart';
import 'package:inspector_ro/pages/list.dart';
import 'package:inspector_ro/pages/list_forklift.dart';
import 'package:inspector_ro/pages/scanner_qr.dart';
import 'package:inspector_ro/pages/operacao.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  // Estanciar Firebase.
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //LISTAS DE EMPILHADEIRAS.
  List<ForkliftModel> listForklift = [];

  String _emailLogado = '';

  // RECUPERA USUARIO LOGADO.
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
      backgroundColor: AppColors.gray1,
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
            Row(
              children: [
                const Text(
                  'Gestão',

                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Operacional',

                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: 'Lufga',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      drawer: Drawer(child: MenuDrawer()),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                // CHECKLIST - ABSTECIMENTO - FROTAS
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 12,
                  children: [
                    // NOVO CHECKLIST
                    Column(
                      children: [
                        SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            // Verifique se o contexto ainda é válido antes de navegar
                            if (!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const listMaquinas(),
                              ),
                            );
                            print('CLICOU');
                          },

                          // Navigator.push(

                          //   context,
                          //   MaterialPageRoute(builder: (_) => ListForklift()),
                          // );
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              color: AppColors.primary2,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Novo Checklist',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secudaryBackground,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Image.asset(
                                        'image/disponivel.png',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ABASTECIMENTO
                    Column(
                      children: [
                        SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            // Verifique se o contexto ainda é válido antes de navegar
                            if (!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const listMaquinas(),
                              ),
                            );
                            print('CLICOU');
                          },

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => ListForklift()),
                          // );
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              color: AppColors.primary2,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.error,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Abastecimento',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secudaryBackground,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Image.asset(
                                        'image/abastecimento.png',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // SCANNER
                    Column(
                      children: [
                        SizedBox(height: 6),
                        GestureDetector(
                          onTap: () async {
                            final codigoLido = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ScannerQrPage(),
                              ),
                            );

                            if (codigoLido != null) {
                              print('QR LIDO: $codigoLido');
                            }
                            if (codigoLido.toString().length != 8) {
                              print('QR INVALIDO');
                              return;
                            }
                            final doc = await FirebaseFirestore.instance
                                .collection('empilhadeiras')
                                .doc(codigoLido.toString())
                                .get();
                            if (doc.exists) {
                              final forklift = ForkliftModel.fromMap(
                                doc.data()!,
                              );

                              print('EMPILHADEIRA: ${forklift.prefixo}');
                            }

                            // FUNÇÃO SCANNER CHECKLIST
                            if (doc.exists) {
                              final forklift = ForkliftModel.fromMap(
                                doc.data()!,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ChecklistForklift(empilhadeira: forklift),
                                ),
                              );
                            }
                          },

                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              color: AppColors.primary2,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.gray4,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Scanner QR',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secudaryBackground,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Image.asset(
                                        'image/qrcode.png',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
                                'image/forklift.png',

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
