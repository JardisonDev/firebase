import 'package:inspector_ro/core/theme/app_colors.dart';
import 'package:inspector_ro/service/auth_service.dart';
import 'package:flutter/material.dart';

AuthService authService = AuthService();

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xfff5f5f9)),
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
                    color: Color(0xff212121),
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: 'Operacional',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        color: Color(0xffd1655b),
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
                  Icon(Icons.person, color: AppColors.gray5, size: 24),
                  SizedBox(width: 10),
                  Title(
                    color: Colors.amberAccent,
                    child: Text(
                      'Dados usuario',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray5,
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
                        color: AppColors.secondary,
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
