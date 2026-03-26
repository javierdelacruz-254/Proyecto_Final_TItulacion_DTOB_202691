import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../viewmodel/chatbot_viewmodel.dart';

class ChatBotScreen extends ConsumerStatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ConsumerState<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends ConsumerState<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 👇 Escuchamos cambios en el provider para hacer scroll
    // cuando se agrega cualquier mensaje nuevo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(chatbotProvider);

      ref.listenManual(chatbotProvider, (previous, next) {
        // Si se agregó un mensaje nuevo hacemos scroll
        if (previous != null &&
            next.messages.length > previous.messages.length) {
          _scrollToBottom();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    // Esperamos 2 frames para asegurar que el ListView ya se reconstruyó
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients &&
            _scrollController.position.hasContentDimensions) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    ref.read(chatbotProvider.notifier).sendMessage(text);
    _controller.clear();
  }

  void _handleSuggestedQuestion(String question) {
    // 1. Ocultamos teclado si está abierto
    FocusScope.of(context).unfocus();
    // 2. Enviamos el mensaje
    ref.read(chatbotProvider.notifier).sendMessage(question);
    // 3. El scroll lo maneja el listener de initState
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatbotProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFF5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE91E8C),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Text('💕', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LactaBot',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Orientación 24/7 • No reemplaza al médico',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner de emergencia
          if (state.showEmergencyBanner)
            _EmergencyBanner(
              onDismiss: () =>
                  ref.read(chatbotProvider.notifier).dismissEmergencyBanner(),
              onFindCenter: () {
                ref.read(chatbotProvider.notifier).dismissEmergencyBanner();
                // Navigator.pushNamed(context, '/directorio-salud');
              },
            ),

          // Lista de mensajes
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              // 👇 +1 para el espacio extra al final
              itemCount: state.messages.length + 1,
              itemBuilder: (context, index) {
                // Último item — espacio para que no tape el input
                if (index == state.messages.length) {
                  return const SizedBox(height: 8);
                }
                return _MessageBubble(message: state.messages[index]);
              },
            ),
          ),

          // Indicador de escritura
          if (state.isLoading) const _TypingIndicator(),

          // Preguntas sugeridas
          if (state.showSuggestions && !state.isLoading)
            _SuggestedQuestions(onTap: _handleSuggestedQuestion),

          // Barra de entrada
          _InputBar(
            controller: _controller,
            isLoading: state.isLoading,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }
}

// ─── Widgets privados ────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: message.isEmergency
              ? Colors.red.shade100
              : isUser
              ? const Color(0xFFFFD6EC)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: message.isEmergency
              ? Border.all(color: Colors.red.shade400, width: 1.5)
              : null,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: message.isEmergency ? Colors.red.shade900 : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFFE91E8C),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'LactaBot está escribiendo...',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EmergencyBanner extends StatelessWidget {
  final VoidCallback onDismiss;
  final VoidCallback onFindCenter;

  const _EmergencyBanner({required this.onDismiss, required this.onFindCenter});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade700,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.local_hospital, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '¡Acude a un centro de salud de inmediato!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          TextButton(
            onPressed: onFindCenter,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: const Text(
              'Ver centros',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 18),
            onPressed: onDismiss,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _SuggestedQuestions extends StatelessWidget {
  final void Function(String) onTap;
  const _SuggestedQuestions({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: ChatbotNotifier.suggestedQuestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ActionChip(
          label: Text(
            ChatbotNotifier.suggestedQuestions[i],
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: const Color(0xFFFCE4EC),
          onPressed: () => onTap(ChatbotNotifier.suggestedQuestions[i]),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        8,
        12,
        MediaQuery.of(context).viewInsets.bottom > 0
            ? 8 // teclado abierto — padding mínimo
            : MediaQuery.of(context).padding.bottom +
                  16, // teclado cerrado — espacio para navbar
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Escribe tu consulta...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: isLoading
                ? Colors.grey.shade300
                : const Color(0xFFE91E8C),
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: isLoading ? null : onSend,
            ),
          ),
        ],
      ),
    );
  }
}
