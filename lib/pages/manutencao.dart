import 'package:flutter/material.dart';
import 'package:inspector_ro/core/theme/app_colors.dart';

class AvisoManutencao extends StatelessWidget {
  const AvisoManutencao({super.key, required this.prefixo});

  final int prefixo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray1,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    Image.asset(
                      'image/manutencao.png',
                      width: 250,
                      height: 250,
                    ),
                    Text(
                      'Empilhadeira em Manutenção',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray6,
                      ),
                    ),
                    SizedBox(height: 16),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: AppColors.gray6),
                        children: [
                          const TextSpan(text: 'Empilhadeira '),
                          TextSpan(
                            text: prefixo.toString(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' está em operação\npor outro operador.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gray6,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text('Fechar Aviso'),
                      const SizedBox(width: 8),
                      const Icon(Icons.close_rounded, color: AppColors.gray1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
