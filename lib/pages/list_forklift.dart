import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inspector_ro/components/menuDrawer.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inspector_ro/repositories/forklift.dart';

class ListForklift extends StatefulWidget {
  const ListForklift({super.key});

  @override
  State<ListForklift> createState() => _ListForkliftState();
}

class _ListForkliftState extends State<ListForklift> {
  List<Forklift> listForklift = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController _controllersearch = TextEditingController();
  String? _selectedStatus;
  String _emailLogado = '';

  // Recuperar Usuario logado.
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
    _queryCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: MenuDrawer()),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Listas',
            style: TextStyle(
              fontFamily: 'Lufga',
              color: Color(0xff212121),
              fontSize: 25,
            ),
            children: [
              TextSpan(
                text: 'Empilhadeiras',
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  // Camada de fundo (efeito de borda lateral/detalhe)
                  Container(
                    width: double.infinity,
                    height: 85,
                    decoration: BoxDecoration(
                      color: AppColors
                          .primary, // Substitua pela sua cor orangePeel
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Camada frontal (Card principal)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                    ), // Cria o recuo para expor o fundo
                    child: Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white, // Substitua pelo seu secondaryText
                      child: Container(
                        width: double.infinity,
                        height: 85,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Barra indicadora
                                  Container(
                                    width: 40,
                                    height: 3,
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const Text(
                                    'Operador identificado',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _emailLogado,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'Bem-vindo ao seu turno!',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: AppColors.gray5,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons
                                  .engineering, // Alternativa ao FontAwesome hardHat
                              color: AppColors.orangePeel,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Area de busca
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Campo de Busca
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _controllersearch,
                          onChanged: (value) {
                            // Lógica de busca ou debounce aqui
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Prefixo',
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF1F4F8), // Ex: gray1
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              size: 24,
                            ),
                            suffixIcon: _controllersearch.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 20),
                                    onPressed: () {
                                      _controllersearch.clear();
                                      setState(() {});
                                    },
                                  )
                                : null,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.orange,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // DropDown de Opções
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedStatus,
                          hint: const Text(
                            "Opções",
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: ['Disponivel', 'Em Operação', 'Manutenção']
                              .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedStatus = val;
                            });
                          },
                        ),
                      ),
                    ),

                    // Botão de Limpar Filtro (Condicional)
                    if (_selectedStatus != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedStatus = null;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.filter_alt_off,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Expanded(
                child: GestureDetector(
                  // Navegar para checklist
                  child: (listForklift.isEmpty)
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.forklift,
                                size: 50,
                                color: AppColors.orangePeel,
                              ),
                              Text('Nenhuma Empilhadeira encontrada'),
                            ],
                          ),
                        )
                      : SizedBox(
                          child: ListView(
                            children: List.generate(listForklift.length, (
                              index,
                            ) {
                              Forklift model = listForklift[index];
                              return SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: AppColors
                                              .primary, // Substitua pela sua cor orangePeel
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 6),
                                        child: Material(
                                          elevation: 1,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: AppColors
                                              .gray1, // Substitua pelo seu secondaryText
                                          child: Container(
                                            width: double.infinity,
                                            height: 90,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: AppColors.primary,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Frota.
                                                      RichText(
                                                        text: TextSpan(
                                                          text: 'FROTA: ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Roboto ',
                                                            color:
                                                                AppColors.gray0,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: model.frota
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: AppColors
                                                                    .gray0,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Prefixo.
                                                      RichText(
                                                        text: TextSpan(
                                                          text: 'prefixo: ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Inter ',
                                                            color: AppColors
                                                                .primaryText,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: model
                                                                  .prefixo
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Inter',
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      // Estado Operacional
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        height: 24,
                                                        decoration: BoxDecoration(
                                                          color: switch (model
                                                              .estadoOperacional) {
                                                            'Disponível' =>
                                                              AppColors
                                                                  .disponivel,
                                                            'Manutenção' =>
                                                              AppColors
                                                                  .manutencao,
                                                            'Em operação' =>
                                                              AppColors
                                                                  .emOperacao,
                                                            null =>
                                                              Colors
                                                                  .grey, // Trata se o campo estiver nulo no Firebase
                                                            _ =>
                                                              Colors
                                                                  .black, // Trata qualquer outro texto que não mapeamos
                                                          },

                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          model.estadoOperacional ==
                                                                  'Disponível'
                                                              ? 'Disponível'
                                                              : model.estadoOperacional ==
                                                                    'Manutenção'
                                                              ? 'Manutenção'
                                                              : 'Em operação',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .secondaryText,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Roboto',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .engineering, // Alternativa ao FontAwesome hardHat
                                                  color: AppColors.orangePeel,
                                                  size: 35,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // ListTile(
                              //   leading: const Icon(Icons.forklift),
                              //   title: Text(model.prefixo.toString()),
                              //   subtitle: Text(
                              //     model.km.toString() + model.frota.toString(),
                              //   ),
                              // );
                            }),
                          ),
                        ),

                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Pegar dados do Firebase.
  _queryCollection() async {
    List<Forklift> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('empilhadeiras')
        .get();

    for (var doc in snapshot.docs) {
      print(doc.data());
      temp.add(Forklift.fromMap(doc.data()));
    }
    setState(() {
      listForklift = temp;
    });
  }
}
