import 'package:firebase_auth/firebase_auth.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/service/auth_service.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: BoxDecoration(color: AppColors.gray1),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Menu',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    color: AppColors.gray1,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Operacional',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Divider(),

              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person, color: AppColors.primary, size: 24),
                  SizedBox(width: 10),
                  Title(
                    color: Colors.amberAccent,
                    child: Text(
                      user?.email ?? 'Usuario  não logado',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Padding(padding: EdgeInsets.only(top: 12)),

              // Metodo Sair usuario aqui.
              GestureDetector(
                onTap: () {
                  authService.sairUsuario();
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Sair',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
