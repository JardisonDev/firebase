import 'package:flutter/material.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({super.key});

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  final _formChave = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmacaoSenhaController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: SingleChildScrollView(
            child: Form(
              key: _formChave,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Criar',
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            color: Color(0xff212121),
                            fontSize: 25,
                          ),
                          children: [
                            TextSpan(
                              text: 'Conta',
                              style: TextStyle(
                                fontFamily: 'Lufga',
                                color: Color(0xffd1655b),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xff464656),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Preecha os dados para novo cadastro',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xff27292d),
                    ),
                  ),
                  SizedBox(height: 24),

                  RichText(
                    text: TextSpan(
                      text: 'Nome Operador - ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Color(0xff2e2e2e),
                      ),
                      children: [
                        TextSpan(
                          text: 'Primeiro nome',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Color(0xff9090a0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Campo de texto para nome
                      TextFormField(
                        controller: _nomeController,
                        keyboardType: TextInputType.name,
                        cursorColor: Color(0xff373c3e),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffe9e9ee),
                          isDense: true,
                          labelText: 'Nome...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            // Define o estilo do texto de dica
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Color(0xff373c3e),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE0E0E0), // Cor da bordinha cinza
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (value.contains(RegExp(r'\d'))) {
                            return 'Nome não pode conter números';
                          }
                          if (value.length < 2) {
                            return 'Nome deve ter pelo menos 2 caracteres';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'E-mail',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff2e2e2e),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),

                      // Campo de texto para email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(0xff373c3e),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffe9e9ee),
                          isDense: true,
                          labelText: 'E-mail...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            // Define o estilo do texto de dica
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Color(0xff373c3e),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE0E0E0), // Cor da bordinha cinza
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (value.length < 2) {
                            return 'Nome deve ter pelo menos 2 caracteres';
                          }
                          if (!value.contains('@')) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Matrícula',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff2e2e2e),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),

                      // Campo de texto para matrícula
                      TextFormField(
                        // Define o tipo de teclado para nome
                        keyboardType: TextInputType.number,
                        cursorColor: Color(0xff373c3e),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffe9e9ee),
                          isDense: true,
                          labelText: 'Matrícula...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            // Define o estilo do texto de dica
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Color(0xff373c3e),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE0E0E0), // Cor da bordinha cinza
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff2e2e2e),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),

                      // Campo de texto para senha
                      TextFormField(
                        controller: _senhaController,
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        cursorColor: Color(0xff373c3e),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          filled: true,
                          fillColor: Color(0xffe9e9ee),
                          isDense: true,
                          labelText: 'Senha...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            // Define o estilo do texto de dica
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Color(0xff373c3e),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE0E0E0), // Cor da bordinha cinza
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Confirmação de Senha',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xff2e2e2e),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),

                      // Campo de texto para confirmação de senha
                      TextFormField(
                        controller: _confirmacaoSenhaController,
                        keyboardType: TextInputType.name,
                        obscureText: true,
                        cursorColor: Color(0xff373c3e),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          filled: true,
                          fillColor: Color(0xffe9e9ee),
                          isDense: true,
                          labelText:
                              'Confirmação de senha                                                                                               Senha...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelStyle: TextStyle(
                            // Define o estilo do texto de dica
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w100,
                            color: Color(0xff373c3e),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE0E0E0), // Cor da bordinha cinza
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 12),
                      ChoiceChip(
                        label: Text('Escolha uma opção'),
                        selected: false,
                        onSelected: (bool selected) {
                          // Lógica para lidar com a seleção do chip
                        },
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd1655b),
                          fixedSize: const Size(230, 40),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          // Lógica de login aqui
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Lógica do botão de Criar Conta
  // _botaocriarcontaClicado() {
  //   String nome = _nomeController.text;
  //   String email = _emailController.text;
  //   String senha = _senhaController.text;
  //   if (_formChave.currentState!.validate()) {
  //     _autenService
  //         .cadastroUsuario(nome: nome, email: email, senha: senha)
  //         .then((String? erro) {
  //           if (erro != null) {
  //             mopstrarShowSnacbar(context: context, mensagen: erro);
  //           } else {
  //             // Deu certo
  //             mopstrarShowSnacbar(
  //               context: context,
  //               mensagen: 'Conta criada com sucesso!',
  //               iserror: false,
  //             );
  //           }
  //         });
  //   }
  // }
}
