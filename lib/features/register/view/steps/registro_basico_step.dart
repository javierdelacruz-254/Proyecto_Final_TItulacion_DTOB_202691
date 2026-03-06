import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/view/widgets/celular_formatter.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';

class RegistroBasicoStep extends ConsumerStatefulWidget {
  const RegistroBasicoStep({super.key});

  @override
  ConsumerState<RegistroBasicoStep> createState() => RegistroBasicoStepState();
}

class RegistroBasicoStepState extends ConsumerState<RegistroBasicoStep> {
  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _celularController = TextEditingController();
  final _celularConfianzaController = TextEditingController();
  final _edadController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  final _photoUrlController = TextEditingController();

  bool _showCelularConfianza = false;

  Timer? _debounce;
  bool _emailExists = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.registroBasicoModel;

    _emailController.addListener(_onEmailChanged);

    if (model != null) {
      _fullnameController.text = model.fullname;
      _dniController.text = model.dni;
      _emailController.text = model.email;
      _passwordController.text = state.password ?? '';
      _celularController.text = model.celular;
      _celularConfianzaController.text = model.celularConfianza ?? '';
      _edadController.text = model.edad.toString();
      _departamentoController.text = model.departamento;
      _provinciaController.text = model.provincia;
      _distritoController.text = model.distrito;
      _photoUrlController.text = model.photoUrl ?? '';
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _fullnameController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _celularController.dispose();
    _celularConfianzaController.dispose();
    _edadController.dispose();
    _departamentoController.dispose();
    _provinciaController.dispose();
    _distritoController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = RegistroBasicoModel(
      fullname: _fullnameController.text.trim(),
      dni: _dniController.text.trim(),
      email: _emailController.text.trim(),
      celular: _celularController.text.trim(),
      celularConfianza: _celularConfianzaController.text.trim().isEmpty
          ? null
          : _celularConfianzaController.text.trim(),
      edad: int.parse(_edadController.text.trim()),
      departamento: _departamentoController.text.trim(),
      provincia: _provinciaController.text.trim(),
      distrito: _distritoController.text.trim(),
      photoUrl: _photoUrlController.text.trim().isEmpty
          ? null
          : _photoUrlController.text.trim(),
    );

    // Guardar en el ViewModel
    ref.read(registerViewModelProvider.notifier).setRegistroBasico(model);
    ref
        .read(registerViewModelProvider.notifier)
        .setPassword(_passwordController.text.trim());

    return true;
  }

  void _onEmailChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final email = _emailController.text.trim();
      if (email.isEmpty) {
        setState(() {
          _emailExists = false;
          _emailError = null;
        });
        return;
      }

      final exists = await ref
          .read(registerViewModelProvider.notifier)
          .checkEmailExists(email);

      setState(() {
        _emailExists = exists;
        _emailError = exists ? "Este correo ya está registrado" : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Información Básica",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 1),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AuthTextField(
                    controller: _fullnameController,
                    hint: "Nombre completo",
                    icon: Icons.person,
                    typeKeyboard: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu nombre completo";
                      }

                      final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$');
                      if (!regex.hasMatch(value.trim())) {
                        return "Solo se permiten letras";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AuthTextField(
                          controller: _dniController,
                          hint: "DNI",
                          icon: Icons.badge,
                          typeKeyboard: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor ingresa tu DNI";
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AuthTextField(
                          controller: _edadController,
                          hint: "Edad",
                          icon: Icons.cake,
                          typeKeyboard: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor ingresa tu edad";
                            }
                            final int? edad = int.tryParse(value);
                            if (edad == null)
                              return "Debe ser un número válido";
                            if (edad <= 0) return "Edad debe ser mayor a 0";
                            if (edad > 120) return "Edad debe ser menor a 120";
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _emailController,
                    hint: "Email",
                    icon: Icons.email,
                    typeKeyboard: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu correo";
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Correo inválido";
                      }
                      if (_emailExists) return _emailError;
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    hint: "Contraseña",
                    icon: Icons.lock,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu contraseña";
                      }
                      if (value.length < 6) {
                        return "La contraseña debe tener al menos 6 caracteres";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _celularController,
                    hint: "Celular",
                    icon: Icons.phone,
                    typeKeyboard: TextInputType.phone,
                    validator: (value) {
                      String digitsOnly = value!.replaceAll(' ', '');
                      if (digitsOnly.isEmpty) {
                        return "Por favor ingresa tu número de celular";
                      }
                      if (!RegExp(r'^9\d{8}$').hasMatch(digitsOnly)) {
                        return "Debe empezar con 9 y tener 9 dígitos";
                      }
                      return null;
                    },
                    inputFormatters: [CelularFormatter()],
                  ),
                  const SizedBox(height: 16),

                  if (!_showCelularConfianza)
                    Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showCelularConfianza = true;
                                });
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "Agregar Celular de Confianza",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight.withOpacity(
                                        0.5,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.add, size: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Opcional: Número de confianza para la madre",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        AuthTextField(
                          controller: _celularConfianzaController,
                          hint: "Celular de confianza",
                          icon: Icons.phone_android,
                          typeKeyboard: TextInputType.phone,
                          validator: (value) {
                            if (!_showCelularConfianza) {
                              return null;
                            }
                            String digitsOnly = value!.replaceAll(' ', '');
                            if (digitsOnly.isEmpty) {
                              return "Por favor ingresa un número de confianza";
                            }
                            if (!RegExp(r'^9\d{8}$').hasMatch(digitsOnly)) {
                              return "Debe empezar con 9 y tener 9 dígitos";
                            }
                            return null;
                          },
                          inputFormatters: [CelularFormatter()],
                        ),
                      ],
                    ),
                    crossFadeState: _showCelularConfianza
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _departamentoController,
                    hint: "Departamento",
                    icon: Icons.map,
                    validator: (value) => value == null || value.isEmpty
                        ? "Campo obligatorio"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _provinciaController,
                    hint: "Provincia",
                    icon: Icons.location_city,
                    validator: (value) => value == null || value.isEmpty
                        ? "Campo obligatorio"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _distritoController,
                    hint: "Distrito",
                    icon: Icons.location_on,
                    validator: (value) => value == null || value.isEmpty
                        ? "Campo obligatorio"
                        : null,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
