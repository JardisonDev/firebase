import 'package:flutter/material.dart';

/// Classe centralizadora de cores do projeto.
/// Use AppColors.nomeDaCor para acessar em qualquer lugar.
class AppColors {
  AppColors._(); // Impede a criação de instâncias AppColors()

  // --- BRAND COLORS (Identidade Visual) ---
  static const Color primary = Color(0xFFC4603F); // Laranja Principal
  static const Color orangePeel = Color(0xffd1655b);
  static const Color secondary = Color(
    0xFFFFFFFF,
  ); // Bege clarinho (Fundo de botões/cards)
  static const Color tertiary = Color(0xFFEE8B60); // Laranja Vibrante
  static const Color alternate = Color(
    0xFF94A3B8,
  ); // Azul acinzentado (Secundário/Desativado)

  // --- TYPOGRAPHY & BACKGROUND (Textos e Fundos) ---
  static const Color primaryText = Color(0xFF323232); // Texto Escuro (Títulos)
  static const Color secondaryText = Color(
    0xFFFFFFFF,
  ); // Texto Branco (Sobre fundos escuros)
  static const Color primaryBackground = Color(
    0xFF1B1B1B,
  ); // Fundo Principal (Dark Mode)
  static const Color secondaryBackground = Color(
    0xFF1C262B,
  ); // Fundo de Cards/Seções

  // --- ESCALA DE CINZAS (Novas cores da imagem) ---
  static const Color gray6 = Color(0xFF464656); // Cinza mais escuro da escala
  static const Color gray5 = Color(0xFF626273);
  static const Color gray4 = Color(0xFF9090A0);
  static const Color gray3 = Color(0xFFC6C6CD);
  static const Color gray2 = Color(0xFFE9E9EE);
  static const Color gray1 = Color(0xFFF5F5F9);
  static const Color gray0 = Color(0xFF27292D); // Cinza "quase preto"

  // --- SEMANTIC COLORS (Status e Avisos) ---
  static const Color success = Color(0xFF249689); // Sucesso / Positivo
  static const Color error = Color(0xFFFF5963); // Erro / Perigo
  static const Color warning = Color(0xFFF9D02B); // Alerta / Atenção
  static const Color active = Color(0xFF4CAF50); // Online / Ativo
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
