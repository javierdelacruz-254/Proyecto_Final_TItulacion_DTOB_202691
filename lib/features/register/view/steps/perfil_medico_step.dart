import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/perfil_medico_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class PerfilMedicoStep extends ConsumerStatefulWidget {
  const PerfilMedicoStep({super.key});

  @override
  ConsumerState<PerfilMedicoStep> createState() => PerfilMedicoStepState();
}

class PerfilMedicoStepState extends ConsumerState<PerfilMedicoStep> {
  final _formKey = GlobalKey<FormState>();

  bool _diabetes = false;
  bool _hipertension = false;
  bool _enfermedadesAutoinmunes = false;
  bool _hipoHiperTiroidismo = false;
  bool _obesidad = false;
  bool _anemiaGrave = false;
  bool _enfermedadesCardiacas = false;

  final _otrosController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.perfilMedicoModel;

    if (model != null) {
      _diabetes = model.diabetes;
      _hipertension = model.hipertension;
      _enfermedadesAutoinmunes = model.enfermedadesAutoinmunes;
      _hipoHiperTiroidismo = model.hipoHiperTiroidismo;
      _obesidad = model.obesidad;
      _anemiaGrave = model.anemiaGrave;
      _enfermedadesCardiacas = model.enfermedadesCardiacas;
      _otrosController.text = model.otros ?? '';
    }
  }

  @override
  void dispose() {
    _otrosController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = PerfilMedicoModel(
      diabetes: _diabetes,
      hipertension: _hipertension,
      enfermedadesAutoinmunes: _enfermedadesAutoinmunes,
      hipoHiperTiroidismo: _hipoHiperTiroidismo,
      obesidad: _obesidad,
      anemiaGrave: _anemiaGrave,
      enfermedadesCardiacas: _enfermedadesCardiacas,
      otros: _otrosController.text.isEmpty
          ? null
          : _otrosController.text.trim(),
    );

    ref.read(registerViewModelProvider.notifier).setPerfilMedico(model);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Perfil Médico", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 1),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCheckbox("Diabetes", _diabetes, (v) => _diabetes = v),
                  _buildCheckbox(
                    "Hipertensión",
                    _hipertension,
                    (v) => _hipertension = v,
                  ),
                  _buildCheckbox(
                    "Enfermedades Autoinmunes",
                    _enfermedadesAutoinmunes,
                    (v) => _enfermedadesAutoinmunes = v,
                  ),
                  _buildCheckbox(
                    "Hipo/Hipertiroidismo",
                    _hipoHiperTiroidismo,
                    (v) => _hipoHiperTiroidismo = v,
                  ),
                  _buildCheckbox("Obesidad", _obesidad, (v) => _obesidad = v),
                  _buildCheckbox(
                    "Anemia Grave",
                    _anemiaGrave,
                    (v) => _anemiaGrave = v,
                  ),
                  _buildCheckbox(
                    "Enfermedades Cardiacas",
                    _enfermedadesCardiacas,
                    (v) => _enfermedadesCardiacas = v,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField("Otros (opcional)", _otrosController),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: (v) {
        setState(() => onChanged(v ?? false));
      },
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
