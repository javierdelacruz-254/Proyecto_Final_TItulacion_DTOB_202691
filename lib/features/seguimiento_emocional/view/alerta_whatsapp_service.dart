import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Servicio para enviar alertas por WhatsApp via UltraMsg
/// directamente desde Flutter, sin Cloud Functions.
///
/// SETUP:
///   1. Reemplaza [_instanceId] y [_token] con tus credenciales de UltraMsg
///   2. Agrega http al pubspec.yaml:
///        dependencies:
///          http: ^1.2.0
class AlertaWhatsAppService {
  // ── Credenciales UltraMsg ────────────────────────────────────────────────
  // Encuéntralas en: https://app.ultramsg.com → tu instancia → Settings
  static String get _instanceId => dotenv.env['ULTRAMSG_INSTANCE'] ?? '';
  static String get _token      => dotenv.env['ULTRAMSG_TOKEN'] ?? '';

  static const String _baseUrl    = 'https://api.ultramsg.com';

  // ── Enviar mensaje ───────────────────────────────────────────────────────

  /// Envía un mensaje de WhatsApp al [telefono] con el [mensaje] indicado.
  /// El [telefono] puede venir en cualquier formato peruano:
  ///   "961 777 998", "+51961777998", "51961777998" → todos funcionan.
  static Future<bool> enviarMensaje({
    required String telefono,
    required String mensaje,
  }) async {
    try {
      final telefonoNormalizado = _normalizarTelefono(telefono);
      if (telefonoNormalizado == null) {
        print('[UltraMsg] Número inválido: $telefono');
        return false;
      }

      final url = Uri.parse('$_baseUrl/$_instanceId/messages/chat');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': _token,
          'to':    telefonoNormalizado,
          'body':  mensaje,
        }),
      ).timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print('[UltraMsg] Respuesta: $data');

      // UltraMsg devuelve {"sent": "true"} cuando es exitoso
      return data['sent'] == 'true' || data['sent'] == true;
    } catch (e) {
      print('[UltraMsg] Error al enviar: $e');
      return false;
    }
  }

  // ── Construir y enviar alerta de embarazo ────────────────────────────────

  static Future<bool> enviarAlertaEmbarazo({
    required String telefono,
    required String nombreMadre,
    required int estadoAnimo,
    required List<String> sintomasGraves,
    required String presion,
    int? semanaGestacion,
  }) async {
    String mensaje = '🔔 *LactaAmor — Alerta de salud*\n\n';
    mensaje += '*$nombreMadre* registró señales que podrían requerir atención médica.\n\n';
    mensaje += '📋 *Etapa:* Embarazo';
    if (semanaGestacion != null) mensaje += ' (semana $semanaGestacion)';
    mensaje += '\n';

    if (estadoAnimo <= 2) {
      final emojis = {1: '😢 Muy mal', 2: '😟 Triste'};
      mensaje += '• Estado de ánimo: ${emojis[estadoAnimo] ?? estadoAnimo}\n';
    }
    if (sintomasGraves.isNotEmpty) {
      mensaje += '• Síntomas graves: ${sintomasGraves.join(', ')}\n';
    }
    if (presion.isNotEmpty && presion != '/') {
      mensaje += '• Presión arterial: $presion mmHg\n';
    }

    mensaje += '\nPor favor contáctala o sugiérele ir al centro de salud más cercano. 🏥';

    return enviarMensaje(telefono: telefono, mensaje: mensaje);
  }

  // ── Construir y enviar alerta de postparto ───────────────────────────────

  static Future<bool> enviarAlertaPostparto({
    required String telefono,
    required String nombreMadre,
    required int estadoAnimo,
    required List<String> sintomasGraves,
    required bool hayAlertaMadre,
    required bool hayAlertaBebe,
    String? temperaturaBebe,
    String? colorDeposicion,
  }) async {
    String mensaje = '🔔 *LactaAmor — Alerta de salud*\n\n';
    mensaje += '*$nombreMadre* registró señales que podrían requerir atención médica.\n\n';
    mensaje += '📋 *Etapa:* Postparto\n';

    if (hayAlertaMadre) {
      mensaje += '\n🩺 *Sobre la madre:*\n';
      if (estadoAnimo <= 2) {
        final emojis = {1: '😢 Muy mal', 2: '😟 Triste'};
        mensaje += '• Ánimo: ${emojis[estadoAnimo] ?? estadoAnimo}\n';
      }
      if (sintomasGraves.isNotEmpty) {
        mensaje += '• Síntomas: ${sintomasGraves.join(', ')}\n';
      }
    }

    if (hayAlertaBebe) {
      mensaje += '\n👶 *Sobre el bebé:*\n';
      if (temperaturaBebe != null && temperaturaBebe.isNotEmpty) {
        mensaje += '• Temperatura: $temperaturaBebe°C\n';
      }
      if (colorDeposicion != null && colorDeposicion.isNotEmpty) {
        mensaje += '• Deposición: $colorDeposicion\n';
      }
    }

    mensaje += '\nPor favor contáctala o sugiérele ir al centro de salud más cercano. 🏥';

    return enviarMensaje(telefono: telefono, mensaje: mensaje);
  }

  // ── Normalizar número peruano ────────────────────────────────────────────

  /// Convierte cualquier formato de número peruano al formato que acepta UltraMsg.
  /// UltraMsg acepta: "51961777998" (código país + 9 dígitos, sin +)
  static String? _normalizarTelefono(String telefono) {
    // Quitar todo lo que no sea dígito
    final soloDigitos = telefono.replaceAll(RegExp(r'[^0-9]'), '');

    if (soloDigitos.isEmpty) return null;

    // Ya tiene código de país Perú: 51XXXXXXXXX (11 dígitos)
    if (soloDigitos.startsWith('51') && soloDigitos.length == 11) {
      return soloDigitos;
    }
    // Solo 9 dígitos (número local peruano)
    if (soloDigitos.length == 9) {
      return '51$soloDigitos';
    }
    // 10 dígitos empezando con 0
    if (soloDigitos.startsWith('0') && soloDigitos.length == 10) {
      return '51${soloDigitos.substring(1)}';
    }

    return null; // formato no reconocido
  }
}