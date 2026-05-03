import 'package:flutter/material.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/service/auth_service.dart';

class redefinirSenha extends StatefulWidget {
  const redefinirSenha({super.key});

  @override
  State<redefinirSenha> createState() => _redefinirSenhaState();
}

class _redefinirSenhaState extends State<redefinirSenha> {
  TextEditingController _emailcontoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Recuperar',
                                style: TextStyle(
                                  fontFamily: 'Lufga',
                                  color: Color(0xff212121),
                                  fontSize: 25,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Acesso',
                                    style: TextStyle(
                                      fontFamily: 'Lufga',
                                      color: Color(0xffd1655b),
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsetsGeometry.all(12)),

                        Stack(
                          children: [
                            // Container Fundo
                            Container(
                              height: 120,
                              width: double.infinity,
                              //color: Color(0xffd1655b),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primary,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.secondary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Segurança',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Text(
                                        'Sistema de Segurança',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff323232),
                                          height: 1,
                                        ),
                                      ),
                                      Text(
                                        'Informe seu e-mail ou matrícula cadastrada para receber um código de redefinição.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          //fontFamily: 'Inter',
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff323232),
                                          //height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(12)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'E-mail',
                            style: TextStyle(
                              color: Color(0xff323232),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(4)),

                        TextFormField(
                          controller: _emailcontoller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (value.length < 6) {
                              return 'O e-mail deve conter mais de 6 caracteres';
                            }
                            if (!value.contains('@')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xffd1655b),
                            ),
                            filled: true,
                            fillColor: const Color(0xfff9fafb),
                            // 1. Configuração da borda quando o campo está parado
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xff9090a0),
                                width: 0.1, // Ajustado de 0.1 para 1
                              ),
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // Ajustado de 8 para 12
                            ),
                            // 2. Configuração da borda quando o usuário clica (foco)
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(
                                  0xffd1655b,
                                ), // Você pode trocar por outra cor se quiser destaque
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            // Borda padrão de fallback
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Digite seu e-mail',
                            hintStyle: const TextStyle(
                              //fontFamily: 'Inter',
                              color: Color(0xff626273),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(12)),
                        Text(
                          'Caso não tem acesso ao e-mail, entre em contato com o suporte técnico',
                        ),
                      ],
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Lógica para redefinir senha aqui.
                    if (_formKey.currentState!.validate()) {
                      _redefinirSenhar();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffd1655b),
                    fixedSize: const Size(230, 40),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redefinirSenhar() {
    String email = _emailcontoller.text;
    authService.redefinirSenha(email: email);
  }
}
