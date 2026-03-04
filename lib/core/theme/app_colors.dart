import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Colores principales
  static const primary = Color(0xFF6EC1E4); // Azul calmante
  static const secondary = Color(0xFFF9AFAE); // Rosa suave, confort

  // Variaciones del color principal
  static const primaryLight = Color(0xFFB3E0F7); // Azul pastel más claro
  static const primaryDark = Color(0xFF3B9ACC); // Azul más intenso

  // Neutros
  static const background = Color(0xFFFFFBF7); // Crema suave
  static const surface = Color(
    0xFFFFFFFF,
  ); // Blanco puro para cards o superficies

  // Texto
  static const textPrimary = Color(
    0xFF333333,
  ); // Gris oscuro, buena legibilidad
  static const textSecondary = Color(0xFF666666); // Gris medio

  // Estados
  static const success = Color(0xFF4CAF50); // Verde confianza, éxito
  static const error = Color(0xFFF44336); // Rojo alerta
  static const warning = Color(0xFFFFC107); // Amarillo suave para advertencias
  static const info = Color(0xFFA3D5D3);
}
