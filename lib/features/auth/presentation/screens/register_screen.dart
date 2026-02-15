import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';
import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  final dniCtrl = TextEditingController();
  final celularCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final semanasCtrl = TextEditingController();

  bool haDadoLuz = false;
  bool? lactanciaExclusiva;
  bool? complicaciones;

  DateTime? fechaParto;
  DateTime? fechaNacimiento;

  String? tipoParto;
  int escalaEmocional = 3;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    ref.listen(authProvider, (prev, next) {
      if (next.status == AuthStatus.authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Registro exitoso 🎉"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        Navigator.pop(context);
      }

      if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? "Error en registro"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Crear cuenta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Registro de Mamá 💕",
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 30),

              AuthTextField(
                controller: nombresCtrl,
                hint: "Nombres",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: apellidosCtrl,
                hint: "Apellidos",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: dniCtrl,
                hint: "DNI",
                icon: Icons.badge,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: edadCtrl,
                hint: "Edad",
                icon: Icons.cake,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: celularCtrl,
                hint: "Celular",
                icon: Icons.phone,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: emailCtrl,
                hint: "Correo",
                icon: Icons.email,
              ),
              const SizedBox(height: 16),

              AuthTextField(
                controller: passwordCtrl,
                hint: "Contraseña",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 24),

              SwitchListTile(
                title: const Text("¿Ya dio a luz?"),
                value: haDadoLuz,
                onChanged: (value) {
                  setState(() => haDadoLuz = value);
                },
              ),

              const SizedBox(height: 20),

              if (!haDadoLuz) ...[
                AuthTextField(
                  controller: semanasCtrl,
                  hint: "Semanas de embarazo",
                  icon: Icons.pregnant_woman,
                ),
              ],

              if (haDadoLuz) ...[
                const SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Tipo de parto"),
                  items: const [
                    DropdownMenuItem(value: "Natural", child: Text("Natural")),
                    DropdownMenuItem(value: "Cesárea", child: Text("Cesárea")),
                  ],
                  onChanged: (value) => tipoParto = value,
                ),

                SwitchListTile(
                  title: const Text("¿Lactancia exclusiva?"),
                  value: lactanciaExclusiva ?? false,
                  onChanged: (value) {
                    setState(() => lactanciaExclusiva = value);
                  },
                ),
              ],

              const SizedBox(height: 20),

              const Text("Escala emocional (1-5)"),
              Slider(
                value: escalaEmocional.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: escalaEmocional.toString(),
                onChanged: (value) {
                  setState(() => escalaEmocional = value.toInt());
                },
              ),

              const SizedBox(height: 30),

              state.status == AuthStatus.loading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : AuthButton(
                      text: "Registrarme",
                      onPressed: () {
                        final user = UserModel(
                          uid: '',
                          nombres: nombresCtrl.text,
                          apellidos: apellidosCtrl.text,
                          dni: dniCtrl.text,
                          celular: celularCtrl.text,
                          email: emailCtrl.text,
                          edad: int.parse(edadCtrl.text),
                          haDadoLuz: haDadoLuz,
                          semanasEmbarazo: haDadoLuz
                              ? null
                              : int.tryParse(semanasCtrl.text),
                          fechaAproxParto: fechaParto,
                          fechaNacimientoBebe: fechaNacimiento,
                          tipoParto: tipoParto,
                          complicaciones: complicaciones,
                          lactanciaExclusiva: lactanciaExclusiva,
                          escalaEmocional: escalaEmocional,
                        );

                        ref
                            .read(authProvider.notifier)
                            .register(user, passwordCtrl.text);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
