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

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Cabeçalho
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.precision_manufacturing_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 12),

                  Text(
                    'CheckPoint',
                    style: TextStyle(
                      fontFamily: 'Antipasto',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    'Gestão Inteligente de Frota',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            // Equipamento ativo
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.gray2,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.forklift, color: AppColors.primary),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Equipamento ativo',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gray0,
                            ),
                          ),
                          Text(
                            'EMP-025',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: AppColors.gray0,
                    ),
                  ],
                ),
              ),
            ),

            Divider(),

            // Menus
            ListTile(
              leading: Icon(
                Icons.dashboard_customize_rounded,
                color: AppColors.primary,
                size: 24,
              ),
              title: Text(
                'Painel Operacional',
                style: TextStyle(color: AppColors.gray6),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.forklift, color: AppColors.primary, size: 24),
              title: Text('Frota', style: TextStyle(color: AppColors.gray6)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.assignment_turned_in_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              title: Text(
                'Checklists',
                style: TextStyle(color: AppColors.gray6),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.build_circle_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              title: Text(
                'Manutenções',
                style: TextStyle(color: AppColors.gray6),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: AppColors.primary,
                size: 24,
              ),
              title: Text(
                'Meu Perfil',
                style: TextStyle(color: AppColors.gray6),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),

            Spacer(),

            Divider(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'CheckPoint v1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
    // Container(
    //   decoration: BoxDecoration(color: AppColors.gray1),
    //   child: SafeArea(
    //     child: Padding(
    //       padding: EdgeInsets.all(16),
    //       child: ListView(
    //         children: [
    //           AppBar(title: Text('Otrack')),
    //           RichText(
    //             text: TextSpan(
    //               text: 'Menu',
    //               style: TextStyle(
    //                 fontFamily: 'Lufga',
    //                 color: AppColors.gray1,
    //                 fontSize: 18,
    //               ),
    //               children: [
    //                 TextSpan(
    //                   text: 'Operacional',
    //                   style: TextStyle(
    //                     fontFamily: 'Lufga',
    //                     color: AppColors.primary,
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 16),

    //           Divider(),

    //           SizedBox(height: 16),
    //           Row(
    //             children: [
    //               Icon(Icons.person, color: AppColors.primary, size: 24),
    //               SizedBox(width: 10),
    //               Title(
    //                 color: Colors.amberAccent,
    //                 child: Text(
    //                   user?.email ?? 'Usuario  não logado',
    //                   style: TextStyle(
    //                     fontSize: 15,
    //                     fontFamily: 'Inter',
    //                     fontWeight: FontWeight.w500,
    //                     color: AppColors.gray1,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 16),

    //           Padding(padding: EdgeInsets.only(top: 12)),

    //           // Metodo Sair usuario aqui.
    //           GestureDetector(
    //             onTap: () {
    //               authService.sairUsuario();
    //             },
    //             child: Container(
    //               margin: const EdgeInsets.all(8),
    //               height: 40,
    //               decoration: BoxDecoration(
    //                 color: AppColors.primary,
    //                 borderRadius: BorderRadius.circular(16),
    //               ),
    //               child: const Center(
    //                 child: Text(
    //                   'Sair',
    //                   style: TextStyle(
    //                     color: AppColors.primary,
    //                     fontWeight: FontWeight.w900,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
