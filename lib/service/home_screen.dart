import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/pages/checklist.dart';
import 'package:inspector_ro/repositories/forklift.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _emailLogado = '';

  // Lista das maquinas.
  List<Forklift> listForklift = [];

  // Estaciar Firebase.
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Recuperar Usuario logado
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
    super.initState();
    _recuperarUsuario();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_emailLogado)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFormModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (listForklift.isEmpty)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.forklift, size: 45, color: AppColors.primary),
                  SizedBox(height: 20),
                  Text(
                    "Nenhuma lista ainda.\nVamos criar a primeira?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return _refresh();
              },
              child: ListView(
                children: List.generate(listForklift.length, (index) {
                  Forklift model = listForklift[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Container(
                        height:
                            100, // Altura ajustada para caber o botão e os textos
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          // Sombra suave para dar o efeito de elevação
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray1,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 6,
                              decoration: BoxDecoration(
                                color: AppColors.orangePeel,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsGeometry.fromLTRB(
                                20,
                                12,
                                12,
                                12,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "FROTA: ${model.frota ?? '---'}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                            Text(
                                              "Prefixo: ${model.prefixo ?? '---'}",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Botão de Status (O retângulo verde da imagem)// Botão de Status (O retângulo verde da imagem)
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            // color: statusColor,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  );
                }),
              ),
            ),
    );
  }

  // Ação de salvar do Firebase.
  showFormModal() {
    // Labels à serem mostradas no Modal
    //String title = "Adicionar Listin";
    String confirmationButton = "Salvar";
    String skipButton = "Cancelar";

    // Controlador do campo que receberá o nome do Listin
    TextEditingController prefixocontroller = TextEditingController();
    TextEditingController kmcontroller = TextEditingController();
    TextEditingController frotacontroller = TextEditingController();

    // Função do Flutter que mostra o modal na tela
    showModalBottomSheet(
      context: context,

      // Define que as bordas verticais serão arredondadas
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(32.0),

          // Formulário com Título, Campo e Botões
          child: ListView(
            children: [
              Text(
                'Inserir Empilhadeira',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Lufga',
                  color: AppColors.primary,
                ),
              ),
              TextFormField(
                controller: prefixocontroller,
                decoration: const InputDecoration(
                  label: Text("prefixo da Emplhadeira"),
                ),
              ),
              TextFormField(
                controller: kmcontroller,
                decoration: const InputDecoration(label: Text("Km")),
              ),
              TextFormField(
                controller: frotacontroller,
                decoration: const InputDecoration(label: Text("Frota")),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(skipButton),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // 1. Pegue o texto de cada respectivo controlador
                      int? prefixoconvertido = int.tryParse(
                        prefixocontroller.text,
                      );
                      int? frotaconvertido = int.tryParse(
                        frotacontroller.text,
                      ); // Use frotacontroller
                      int? kmoconvertido = int.tryParse(kmcontroller.text);

                      // Criar um objeto Forhlift.
                      Forklift listin = Forklift(
                        prefixo: prefixoconvertido,
                        frota: frotaconvertido,
                        km: kmoconvertido,
                      );

                      // Salvar no Firebase.
                      await firestore
                          .collection('empilhadeiras')
                          .doc(listin.prefixo.toString())
                          .set(listin.toMap());

                      // Atualizar a lista na tela!
                      _refresh();
                      // Fechar Modal.
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Text(confirmationButton),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Pegar dados do Firebase.
  _refresh() async {
    List<Forklift> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('empilhadeiras')
        .get();

    for (var doc in snapshot.docs) {
      temp.add(Forklift.fromMap(doc.data()));
    }

    setState(() {
      listForklift = temp;
    });
  }
}
