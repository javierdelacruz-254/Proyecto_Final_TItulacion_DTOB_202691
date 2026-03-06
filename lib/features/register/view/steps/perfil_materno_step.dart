import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/view/widgets/register_checkbox.dart';
import 'package:lactaamor/features/register/view/widgets/register_dropdown.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';

class PerfilMaternoStep extends ConsumerStatefulWidget {
  const PerfilMaternoStep({super.key});

  @override
  ConsumerState<PerfilMaternoStep> createState() => PerfilMaternoStepState();
}

class PerfilMaternoStepState extends ConsumerState<PerfilMaternoStep> {
  final _formKey = GlobalKey<FormState>();

  final _grupoSangreController = TextEditingController();
  final _totalEmbarazosController = TextEditingController();
  EstadoCivil? _estadoCivil;
  RhSangre? _rh;
  bool _primerEmbarazo = true;
  bool _haDadoLuz = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.perfilMaternoModel;

    if (model != null) {
      _estadoCivil = model.estadoCivil;
      _grupoSangreController.text = model.grupoSangre;
      _rh = model.rh;
      _primerEmbarazo = model.primerEmbarazo;
      _totalEmbarazosController.text = model.totalEmbarazos?.toString() ?? '';
      _haDadoLuz = model.haDadoLuz;
    }
  }

  @override
  void dispose() {
    _grupoSangreController.dispose();
    _totalEmbarazosController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = PerfilMaternoModel(
      estadoCivil: _estadoCivil!,
      grupoSangre: _grupoSangreController.text.trim(),
      rh: _rh!,
      primerEmbarazo: _primerEmbarazo,
      totalEmbarazos: _primerEmbarazo
          ? null
          : int.tryParse(_totalEmbarazosController.text.trim()),
      haDadoLuz: _haDadoLuz,
    );

    ref.read(registerViewModelProvider.notifier).setPerfilMaterno(model);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Perfil Materno", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 1),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RegisterDropdown<EstadoCivil>(
                    value: _estadoCivil,
                    icon: Icons.people,
                    hint: "Estado Civil",
                    items: EstadoCivil.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => _estadoCivil = value),
                    validator: (value) => value == null
                        ? "Por favor seleccione su estado civil"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _grupoSangreController,
                    hint: "Grupo Sanguíneo",
                    icon: Icons.healing,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu grupo sanguíneo";
                      }

                      final validGroups = ["A", "B", "AB", "O"];
                      if (!validGroups.contains(value.trim().toUpperCase())) {
                        return "Grupo sanguíneo inválido";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  RegisterDropdown(
                    value: _rh,
                    hint: "RH",
                    icon: Icons.bloodtype, // ícono sugerido
                    items: RhSangre.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _rh = val),
                    validator: (val) =>
                        val == null ? "Campo obligatorio" : null,
                  ),
                  const SizedBox(height: 16),
                  RegisterCheckbox(
                    label: "¿Fue o es tu primer embarazo",
                    value: _primerEmbarazo,
                    onChanged: (v) => setState(() => _primerEmbarazo = v),
                  ),

                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        AuthTextField(
                          controller: _totalEmbarazosController,
                          hint: "Número de embarazos anteriores",
                          icon: Icons.pregnant_woman,
                          typeKeyboard: TextInputType.number,
                          validator: (value) {
                            if (!_primerEmbarazo) {
                              if (value == null || value.isEmpty) {
                                return "Ingresa el número de embarazos anteriores";
                              }
                              final n = int.tryParse(value);
                              if (n == null || n < 0) return "Número inválido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    crossFadeState: !_primerEmbarazo
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),

                  RegisterCheckbox(
                    label: "¿Ha dado a luz?",
                    value: _haDadoLuz,
                    onChanged: (v) {
                      setState(() => _haDadoLuz = v);
                      ref
                          .read(registerViewModelProvider.notifier)
                          .setHaDadoLuz(v);
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
