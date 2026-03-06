import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/view/new_password_screen.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_state.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_button.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterCodeScreen extends ConsumerStatefulWidget {
  final String email;
  const EnterCodeScreen({super.key, required this.email});

  @override
  ConsumerState<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends ConsumerState<EnterCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final PinInputController _pinInputController = PinInputController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen(authViewModelProvider, (previous, next) {
        if (next.error == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  NewPasswordScreen(code: _pinInputController.text.trim()),
            ),
          );
        }

        if (next.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.error ?? "Error")));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verificar correo"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Lottie.asset(
                  'assets/lottie/email_code.json',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(
                      text:
                          "Por favor ingresa el código de 6 dígitos que enviamos a ",
                    ),
                    TextSpan(
                      text: widget.email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: "."),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: MaterialPinField(
                            length: 6,
                            pinController: _pinInputController,
                            keyboardType: TextInputType.number,
                            theme: MaterialPinTheme(
                              cellSize: const Size(45, 50),
                              shape: MaterialPinShape.outlined,
                              borderRadius: BorderRadius.circular(12),
                              focusedFillColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              disabledColor: Colors.grey.shade300,
                            ),
                            onCompleted: (pin) async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .checkAction(pin.trim());
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    AuthButton(
                      text: "Verificar código",
                      isLoading: state.isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(authViewModelProvider.notifier)
                              .checkAction(_pinInputController.text.trim());
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
