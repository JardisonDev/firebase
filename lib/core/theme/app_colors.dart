import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Impede a criação de instâncias AppColors()

  // --- BRAND COLORS (Identidade Visual) ---
  static const Color primary = Color(0xFF5682A9);
  static const Color primary1 = Color(0xFFA9C6E4);
  static const Color primary2 = Color(0xFFE6F0F6);
  static const Color secudary = Color(0xFFFCC43B);
  static const Color superficie = Color(0xff3a3f46);

  // --- TYPOGRAPHY & BACKGROUND (Textos e Fundos) ---
  static const Color primaryText = Color(0xFF2e2e2e); // Texto Escuro (Títulos)
  static const Color secondaryText = Color(0xFFFFFFFF);
  static const Color primaryBackground = Color(0xFF3C3D42);
  static const Color primaryBackgroundLinghet = Color(0xFF52565F);
  static const Color secudaryBackground = Color(0xFFffffff);

  // --- ESCALA DE CINZAS (Novas cores da imagem) ---
  static const Color gray6 = Color(0xFF464656); // Cinza mais escuro da escala
  static const Color gray5 = Color(0xFF626273);
  static const Color gray4 = Color(0xFF9090A0);
  static const Color gray3 = Color(0xFFC6C6CD);
  static const Color gray2 = Color(0xFFE9E9EE);
  static const Color gray1 = Color(0xFFF5F5F9);
  static const Color gray0 = Color(0xFF27292D); // Cinza "quase preto"

  // --- SEMANTIC COLORS (Status e Avisos) ---

  static const Color error = Color(0xFFFF5963); // Erro / Perigo
  static const Color manutencao = Color(0xFFB59410); // Em Manutenção
  static const Color emOperacao = Color(0xFF007a8d); // Em Operação
  static const Color disponivel = Color(0xFF5d823a); // Em Operação
}

// void Text(
//   'Meu Título',
//   style: TextStyle(
//     color: AppColors.primary, // <--- Aqui você chama a cor
//     fontWeight: FontWeight.bold,
//   ),
// )
