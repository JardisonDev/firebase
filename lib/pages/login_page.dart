import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
//import 'package:inspector_ro/pages/criar_conta.dart';
import 'package:inspector_ro/pages/management.dart';
import 'package:inspector_ro/pages/redefinirSenha.dart';
import 'package:inspector_ro/service/auth_service.dart';
import 'package:inspector_ro/widgets/snacbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _seePasword = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  AuthService authService = AuthService();

  //Verifica se o usuario ja fez Login
  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = auth.currentUser;

    if (usuarioLogado != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ManagementScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verificarUsuarioLogado();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
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
                            height: 100,
                            width: double.infinity,
                            //color: Color(0xffd1655b),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.primary2,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bem-vindo!',
                                    style: TextStyle(
                                      fontFamily: 'roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff323232),
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    'Acesse sua conta para continuar.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      //fontFamily: 'Inter',
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff323232),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    //Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'image/Logo-Forklift-black_Prancheta 1.png',
                          height: 70,
                        ),
                        Text(
                          'Fork',
                          style: TextStyle(
                            fontFamily: 'Lufga',

                            color: Color(0xff323232),
                            fontSize: 45,
                            //fontWeight: FontWeight.bold,
                            height: 1,
                            //fontFamily:
                          ),
                        ),
                        Text(
                          'Lift',
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            color: AppColors.primary,
                            fontSize: 45,
                            //fontWeight: FontWeight.w700,
                            height: 1,
                            //fontFamily:
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Preencha os dados para continuar',
                      style: TextStyle(
                        color: Color(0xff323232),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        //fontFamily:
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 3),
                    // Campo E-mail
                    TextFormField(
                      controller: _controllerEmail,
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
                        prefixIcon: Icon(Icons.email, color: AppColors.primary),
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
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Senha',
                        style: TextStyle(
                          color: Color(0xff323232),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Campo Senha
                    TextFormField(
                      controller: _controllerSenha,
                      keyboardType: TextInputType.number,
                      obscureText: _seePasword == false ? true : false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                        isDense: true,
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _seePasword == false
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onTap: () {
                            setState(() {
                              _seePasword = !_seePasword;
                            });
                          },
                        ),

                        prefixIcon: Icon(
                          Icons.password_rounded,
                          color: AppColors.primary,
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
                        hintText: 'Digite sua senha',
                        hintStyle: const TextStyle(
                          //fontFamily: 'Inter',
                          color: Color(0xff626273),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (value.length < 6) {
                          return 'A senha deve conter mais de 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => redefinirSenha(),
                            ),
                          );
                        },
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: AppColors.gray0,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primary1],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica de login aqui
                          _botaoEnviarClicado();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(230, 40),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,

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
                    ),
                    SizedBox(height: 16),

                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // Mude para .push para manter o Login na pilha
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const redefinirSenha(),
                            ),
                          );
                        },
                        child: Text(
                          'Ainda não tem uma conta?',
                          style: TextStyle(
                            color: Color(0xff323232),
                            fontFamily: 'Lufga',
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _botaoEnviarClicado() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (_formKey.currentState!.validate()) {
      _logarUsuario(email: email, senha: senha);
    } else {
      return num;
    }
  }

  // Logar Usuario
  void _logarUsuario({required String email, required String senha}) {
    authService.logarUsuario(email: email, senha: senha).then((String? erro) {
      if (erro != null) {
        ShowSnacbar(context: context, mensagen: erro);
      }
    });
  }

  // botaoprincipalClicado() async {
  //   // Recuperar dados do Campos
  //   String email = _controllerEmail.text;
  //   String senha = _controllerSenha.text;

  //   if (_formKey.currentState!.validate()) {
  //     var erro = await _autenService.loginUsuario(email: email, senha: senha);
  //     if (erro == null) {
  //       if (!mounted) return;
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (_) => const ManagementScreen()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('erro'), backgroundColor: Colors.red),
  //       );
  //     }
  //     //Açao de login aqui
  //     print(' Campos válidos, realizar login');
  //   } else {
  //     print('Campos inválidos, mostrar mensagens de erro');
  //   }
  // }
}
