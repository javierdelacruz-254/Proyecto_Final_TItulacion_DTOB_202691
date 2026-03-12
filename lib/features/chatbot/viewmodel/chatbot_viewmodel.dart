import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import '../models/chat_message.dart';
import '../repository/chatbot_repository.dart';

class ChatbotState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool showEmergencyBanner;
  final String? currentUid; // 👈 agregamos el uid actual

  const ChatbotState({
    this.messages = const [],
    this.isLoading = false,
    this.showEmergencyBanner = false,
    this.currentUid,
  });

  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? showEmergencyBanner,
    String? currentUid,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      showEmergencyBanner: showEmergencyBanner ?? this.showEmergencyBanner,
      currentUid: currentUid ?? this.currentUid,
    );
  }
}

class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository;
  final Ref _ref;

  ChatbotNotifier(this._repository, this._ref)
      : super(const ChatbotState()) {
    _initChat();
  }

  static const List<String> suggestedQuestions = [
    '¿Cómo sé si mi bebé toma suficiente leche?',
    '¿Qué posiciones son mejores para amamantar?',
    '¿Qué alimentos peruanos ayudan a producir más leche?',
    '¿Cuándo debo preocuparme por el llanto de mi bebé?',
  ];

  void _initChat() {
    final profile = _ref.read(homeViewModelProvider).profile;

    // Guardamos el uid del usuario actual
    final uid = profile?.uid;

    final nombre = profile != null && profile.fullname.isNotEmpty
        ? profile.fullname.split(' ').first
        : null;

    final saludo = nombre != null
        ? '¡Hola $nombre! Soy LactaBot 👶💕'
        : '¡Hola mamá! Soy LactaBot 👶💕';

    state = state.copyWith(
      currentUid: uid,
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

  // Verifica si cambió el usuario y resetea si es necesario
  void checkAndResetIfUserChanged() {
    final profile = _ref.read(homeViewModelProvider).profile;
    final newUid = profile?.uid;

    // Si el uid es diferente al guardado, reseteamos el chat
    if (newUid != state.currentUid) {
      _initChat();
    }
  }

  // Reset manual — útil al hacer logout
  void resetChat() {
    _initChat();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.isLoading) return;

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
      profile,
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

final chatbotRepositoryProvider = Provider<ChatbotRepository>(
  (ref) => ChatbotRepository(),
);

final chatbotProvider =
    StateNotifierProvider<ChatbotNotifier, ChatbotState>(
  (ref) => ChatbotNotifier(
    ref.read(chatbotRepositoryProvider),
    ref,
  ),
);