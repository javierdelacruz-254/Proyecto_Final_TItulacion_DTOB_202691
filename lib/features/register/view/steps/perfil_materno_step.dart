import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perfil Materno",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            _buildDropdownEstadoCivil(),
            _buildTextField(
              "Grupo sanguíneo (Ej: A, B, AB, O)",
              _grupoSangreController,
            ),
            _buildDropdownRh(),
            _buildCheckbox(
              label: "¿Es tu primer embarazo?",
              value: _primerEmbarazo,
              onChanged: (v) => setState(() => _primerEmbarazo = v),
            ),
            if (!_primerEmbarazo)
              _buildTextField(
                "Número de embarazos anteriores",
                _totalEmbarazosController,
                keyboardType: TextInputType.number,
              ),
            _buildCheckbox(
              label: "¿Ha dado a luz?",
              value: _haDadoLuz,
              onChanged: (v) {
                setState(() => _haDadoLuz = v);
                ref.read(registerViewModelProvider.notifier).setHaDadoLuz(v);
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownEstadoCivil() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<EstadoCivil>(
        value: _estadoCivil,
        decoration: const InputDecoration(labelText: "Estado Civil"),
        items: EstadoCivil.values
            .map(
              (e) =>
                  DropdownMenuItem(value: e, child: Text(e.name.toUpperCase())),
            )
            .toList(),
        onChanged: (value) => setState(() => _estadoCivil = value),
        validator: (value) => value == null ? "Campo obligatorio" : null,
      ),
    );
  }

  Widget _buildDropdownRh() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<RhSangre>(
        value: _rh,
        decoration: const InputDecoration(labelText: "RH"),
        items: RhSangre.values
            .map(
              (e) =>
                  DropdownMenuItem(value: e, child: Text(e.name.toUpperCase())),
            )
            .toList(),
        onChanged: (value) => setState(() => _rh = value),
        validator: (value) => value == null ? "Campo obligatorio" : null,
      ),
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CheckboxListTile(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        title: Text(label),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? "Campo obligatorio" : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
