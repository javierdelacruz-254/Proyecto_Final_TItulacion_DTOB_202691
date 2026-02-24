import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/screens/new_password_screen.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
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
      ref.listen(authProvider, (previous, next) {
        if (next.status == AuthStatus.verified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  NewPasswordScreen(code: _pinInputController.text.trim()),
            ),
          );
        }

        if (next.status == AuthStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.message ?? "Error")));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message!)));
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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Lottie.asset(
              'assets/lottie/email_code.json',
              width: 150,
              height: 150,
            ),
            Text(
              "Por favor ingresa el código de 6 dígitos que enviamos a ${widget.email}.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MaterialPinField(
                    length: 6,
                    pinController: _pinInputController,
                    keyboardType: TextInputType.number,
                    theme: MaterialPinTheme(
                      cellSize: const Size(50, 56),
                      shape: MaterialPinShape.outlined,
                      borderRadius: BorderRadius.circular(12),
                      focusedFillColor: Theme.of(context).colorScheme.primary,
                      disabledColor: Colors.grey.shade300,
                    ),
                    onCompleted: (pin) {
                      if (_formKey.currentState?.validate() ?? false) {
                        ref.read(authProvider.notifier).checkAction(pin.trim());
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  AuthButton(
                    text: "Verificar código",
                    isLoading: state.status == AuthStatus.loading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(authProvider.notifier)
                            .checkAction(_pinInputController.text.trim());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
