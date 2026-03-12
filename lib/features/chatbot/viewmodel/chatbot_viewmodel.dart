import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../repository/chatbot_repository.dart';

// Estado del chatbot
class ChatbotState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool showEmergencyBanner;

  const ChatbotState({
    this.messages = const [],
    this.isLoading = false,
    this.showEmergencyBanner = false,
  });

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? showEmergencyBanner,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      showEmergencyBanner: showEmergencyBanner ?? this.showEmergencyBanner,
    );
  }
}

// Notifier — equivale al ViewModel en MVVM con Riverpod
class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository;

  ChatbotNotifier(this._repository) : super(const ChatbotState()) {
    _addWelcomeMessage();
  }

  // Preguntas sugeridas según CU-07
  static const List<String> suggestedQuestions = [
    '¿Cómo sé si mi bebé toma suficiente leche?',
    '¿Qué posiciones son mejores para amamantar?',
    '¿Qué alimentos peruanos ayudan a producir más leche?',
    '¿Cuándo debo preocuparme por el llanto de mi bebé?',
  ];

  void _addWelcomeMessage() {
    state = state.copyWith(
      messages: [
        ChatMessage(
          text: '¡Hola mamá! Soy LactaBot 👶💕\n\n'
              'Estoy aquí para orientarte sobre lactancia, '
              'cuidados de tu bebé y tu bienestar. '
              '¿En qué te puedo ayudar hoy?',
          role: MessageRole.bot,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.isLoading) return;

    final userMessage = ChatMessage(
      text: text.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    // Agregamos mensaje del usuario y activamos loading
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      showEmergencyBanner: false,
    );

    final responseText = await _repository.sendMessage(
      state.messages,
      text.trim(),
    );

    // Detectamos si Groq marcó una emergencia
    final isEmergency = responseText.contains('[EMERGENCY_FLAG]');
    final cleanResponse = responseText.replaceAll('[EMERGENCY_FLAG]', '').trim();

    final botMessage = ChatMessage(
      text: cleanResponse,
      role: MessageRole.bot,
      timestamp: DateTime.now(),
      isEmergency: isEmergency,
    );

    state = state.copyWith(
      messages: [...state.messages, botMessage],
      isLoading: false,
      showEmergencyBanner: isEmergency,
    );
  }

  void dismissEmergencyBanner() {
    state = state.copyWith(showEmergencyBanner: false);
  }
}

// Provider global — lo usas en cualquier widget con ref.watch
final chatbotRepositoryProvider = Provider<ChatbotRepository>(
  (ref) => ChatbotRepository(),
);

final chatbotProvider =
    StateNotifierProvider<ChatbotNotifier, ChatbotState>(
  (ref) => ChatbotNotifier(ref.read(chatbotRepositoryProvider)),
);