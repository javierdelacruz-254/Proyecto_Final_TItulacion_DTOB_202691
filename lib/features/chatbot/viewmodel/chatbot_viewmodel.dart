import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import '../models/chat_message.dart';
import '../repository/chatbot_repository.dart';

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

class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository;
  final Ref _ref; // 👈 para leer otros providers

  ChatbotNotifier(this._repository, this._ref)
      : super(const ChatbotState()) {
    _addWelcomeMessage();
  }

  static const List<String> suggestedQuestions = [
    '¿Cómo sé si mi bebé toma suficiente leche?',
    '¿Qué posiciones son mejores para amamantar?',
    '¿Qué alimentos peruanos ayudan a producir más leche?',
    '¿Cuándo debo preocuparme por el llanto de mi bebé?',
  ];

  void _addWelcomeMessage() {
    // Intentamos obtener el nombre para personalizar el saludo
    final profile = _ref.read(homeViewModelProvider).profile;
    final nombre = profile != null && profile.fullname.isNotEmpty
        ? profile.fullname.split(' ').first
        : null;

    final saludo = nombre != null
        ? '¡Hola $nombre! Soy LactaBot 👶💕'
        : '¡Hola mamá! Soy LactaBot 👶💕';

    state = state.copyWith(
      messages: [
        ChatMessage(
          text: '$saludo\n\n'
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

    // Leemos el perfil actualizado en cada mensaje
    final profile = _ref.read(homeViewModelProvider).profile;

    final userMessage = ChatMessage(
      text: text.trim(),
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      showEmergencyBanner: false,
    );

    final responseText = await _repository.sendMessage(
      state.messages,
      text.trim(),
      profile, // 👈 pasamos el perfil real
    );

    final isEmergency = responseText.contains('[EMERGENCY_FLAG]');
    final cleanResponse =
        responseText.replaceAll('[EMERGENCY_FLAG]', '').trim();

    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatMessage(
          text: cleanResponse,
          role: MessageRole.bot,
          timestamp: DateTime.now(),
          isEmergency: isEmergency,
        ),
      ],
      isLoading: false,
      showEmergencyBanner: isEmergency,
    );
  }

  void dismissEmergencyBanner() {
    state = state.copyWith(showEmergencyBanner: false);
  }
}

// Providers
final chatbotRepositoryProvider = Provider<ChatbotRepository>(
  (ref) => ChatbotRepository(),
);

final chatbotProvider =
    StateNotifierProvider<ChatbotNotifier, ChatbotState>(
  (ref) => ChatbotNotifier(
    ref.read(chatbotRepositoryProvider),
    ref, // 👈 pasamos ref para leer homeViewModelProvider
  ),
);