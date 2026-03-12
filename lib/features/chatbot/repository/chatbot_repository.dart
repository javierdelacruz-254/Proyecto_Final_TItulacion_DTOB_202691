import 'package:dio/dio.dart';
import 'package:lactaamor/features/home/models/user_profile_model.dart';
import '../models/chat_message.dart';

class ChatbotRepository {
  final Dio _dio = Dio();

  static const String _apiKey =
      String.fromEnvironment('GROQ_API_KEY', defaultValue: '');

  // Construye el system prompt personalizado con los datos reales de la usuaria
  String _buildSystemPrompt(UserProfileModel? profile) {
    // Contexto de la usuaria
    String contextoUsuaria = '';

    if (profile != null) {
      final nombre = profile.fullname.isNotEmpty
          ? profile.fullname.split(' ').first // Solo primer nombre
          : 'mamá';

      if (profile.haDadoLuz) {
        final semanas = profile.semanasPostParto;
        final dias = profile.diasPostParto;
        final etapa = dias <= 7
            ? 'postparto inmediato (primeros 7 días)'
            : dias <= 42
                ? 'postparto temprano (primeras 6 semanas)'
                : 'postparto tardío';

        contextoUsuaria = '''
DATOS DE LA USUARIA ACTUAL:
- Nombre: $nombre
- Estado: Madre en etapa de $etapa
- Tiempo desde el parto: $semanas semanas ($dias días)
- Lactancia materna exclusiva: ${profile.lactanciaMaterna == true ? 'Sí' : 'No'}
- Anemia grave: ${profile.anemiaGrave == true ? 'Sí — recomendar alimentos ricos en hierro' : 'No'}
${profile.peso != null ? '- Peso del bebé al nacer: ${profile.peso} kg' : ''}
${profile.altura != null ? '- Talla del bebé al nacer: ${profile.altura} cm' : ''}

INSTRUCCIÓN: Llama a la usuaria por su nombre "$nombre" en la primera respuesta 
de cada conversación. Adapta tus respuestas a su etapa postparto actual.
''';
      } else {
        final semanas = profile.semanasEmbarazo;
        final trimestre = semanas <= 12
            ? 'primer trimestre'
            : semanas <= 24
                ? 'segundo trimestre'
                : 'tercer trimestre';

        contextoUsuaria = '''
DATOS DE LA USUARIA ACTUAL:
- Nombre: $nombre
- Estado: Embarazada — $semanas semanas de gestación ($trimestre)
- Anemia grave: ${profile.anemiaGrave == true ? 'Sí — recomendar alimentos ricos en hierro' : 'No'}

INSTRUCCIÓN: Llama a la usuaria por su nombre "$nombre" en la primera respuesta.
Adapta tus respuestas a su semana de embarazo actual ($semanas semanas).
''';
      }
    }

    return '''
Eres "LactaBot", el asistente virtual de LactaAmor, una app de apoyo 
a madres primerizas del Perú. Tu rol es orientar de forma empática, 
clara y en español peruano sobre:
- Lactancia materna (técnicas, posiciones, producción de leche)
- Cuidados básicos del recién nacido
- Nutrición postparto con alimentos peruanos (quinua, kiwicha, maca, etc.)
- Bienestar emocional materno y señales de depresión postparto
- Calendario de vacunas y controles CRED según el MINSA

$contextoUsuaria

REGLAS ESTRICTAS:
1. NUNCA emitas diagnósticos médicos ni prescribas medicamentos.
2. Siempre añade al final: "⚕️ Esta orientación es educativa. Consulta a tu médico."
3. Si detectas palabras de EMERGENCIA (fiebre alta, dificultad respiratoria,
   convulsiones, sangrado intenso, llanto inconsolable más de 3 horas, 
   labios azules, no responde, se cayó) responde ÚNICAMENTE:
   "🚨 EMERGENCIA: [riesgo brevemente]. Acude de inmediato a un centro de salud. [EMERGENCY_FLAG]"
4. Responde de forma cálida, como una amiga que sabe de salud materna.
5. Respuestas concisas — máximo 4 párrafos cortos.
6. Tus fuentes son guías validadas por MINSA y OMS.
''';
  }

  Future<String> sendMessage(
    List<ChatMessage> history,
    String newMessage,
    UserProfileModel? profile, // recibe el perfil
  ) async {
    if (_apiKey.isEmpty) {
      return 'Error: API key no configurada. '
          'Ejecuta la app con --dart-define=GROQ_API_KEY=tu_key';
    }

    try {
      final messages = <Map<String, String>>[
        {'role': 'system', 'content': _buildSystemPrompt(profile)},
      ];

      final recentHistory = history.length > 10
          ? history.sublist(history.length - 10)
          : history;

      for (final msg in recentHistory) {
        messages.add({
          'role': msg.role == MessageRole.user ? 'user' : 'assistant',
          'content': msg.text,
        });
      }

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
          'model': 'llama-3.3-70b-versatile',
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
        return 'La respuesta tardó demasiado. Verifica tu conexión.';
      }
      return 'Error de conexión. Verifica tu internet e intenta de nuevo.';
    } catch (_) {
      return 'Ocurrió un error inesperado. Por favor intenta de nuevo.';
    }
  }
}