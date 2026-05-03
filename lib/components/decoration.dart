import 'package:flutter/material.dart';

InputDecoration getAuthInputDecoration(String label) {
  return InputDecoration(
    label: Text(label),
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
  );
}
