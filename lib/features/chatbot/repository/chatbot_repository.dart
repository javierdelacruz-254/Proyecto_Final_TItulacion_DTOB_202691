import 'package:dio/dio.dart';
import '../models/chat_message.dart';

class ChatbotRepository {
  final Dio _dio = Dio();

  static const String _apiKey =
      String.fromEnvironment('GROQ_API_KEY', defaultValue: '');

  static const String _systemPrompt = '''
Eres "LactaBot", el asistente virtual de LactaAmor, una app de apoyo 
a madres primerizas del Perú. Tu rol es orientar de forma empática, 
clara y en español peruano sobre:
- Lactancia materna (técnicas, posiciones, producción de leche)
- Cuidados básicos del recién nacido
- Nutrición postparto con alimentos peruanos (quinua, kiwicha, maca, etc.)
- Bienestar emocional materno y señales de depresión postparto

REGLAS ESTRICTAS:
1. NUNCA emitas diagnósticos médicos ni prescribas medicamentos.
2. Siempre añade al final de cada respuesta: 
   "⚕️ Esta orientación es educativa. Para diagnósticos, consulta a tu médico."
3. Si detectas palabras de EMERGENCIA como: fiebre alta, dificultad respiratoria,
   convulsiones, sangrado intenso, llanto inconsolable más de 3 horas, labios azules,
   no responde, se cayó — responde ÚNICAMENTE con este formato exacto:
   "🚨 EMERGENCIA: [describe brevemente el riesgo]. Acude de inmediato a un centro de salud. [EMERGENCY_FLAG]"
4. Responde siempre de forma cálida, como una amiga que sabe de salud materna.
5. Tus respuestas deben ser concisas (máximo 4 párrafos cortos).
6. Tus fuentes son guías validadas por MINSA y OMS.
''';

  Future<String> sendMessage(
    List<ChatMessage> history,
    String newMessage,
  ) async {
    print('🔑 API KEY: $_apiKey');
    print('🔑 Longitud: ${_apiKey.length}');
    if (_apiKey.isEmpty) {
      return 'Error: API key no configurada. '
          'Ejecuta la app con --dart-define=GROQ_API_KEY=tu_key';
    }

    try {
      // Construimos el historial en formato OpenAI (Groq lo usa igual)
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': _systemPrompt},
      ];

      // Últimos 10 mensajes para no exceder el límite de tokens
      final recentHistory = history.length > 10
          ? history.sublist(history.length - 10)
          : history;

      for (final msg in recentHistory) {
        messages.add({
          'role': msg.role == MessageRole.user ? 'user' : 'assistant',
          'content': msg.text,
        });
      }

      // Agregamos el mensaje nuevo
      messages.add({'role': 'user', 'content': newMessage});

      final response = await _dio.post(
        'https://api.groq.com/openai/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
        data: {
          'model': 'llama-3.3-70b-versatile', // Mejor modelo gratis de Groq
          'messages': messages,
          'max_tokens': 500,
          'temperature': 0.7,
        },
      );

      final text =
          response.data['choices'][0]['message']['content'] as String?;
      return text ?? 'No pude generar una respuesta.';
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return 'Error: API key inválida. Verifica tu key de Groq.';
      }
      if (e.response?.statusCode == 429) {
        return 'El servicio está muy ocupado. Intenta en unos segundos. 🙏';
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return 'La respuesta tardó demasiado. Verifica tu conexión a internet.';
      }
      return 'Error de conexión. Verifica tu internet e intenta de nuevo.';
    } catch (_) {
      return 'Ocurrió un error inesperado. Por favor intenta de nuevo.';
    }
  }
}