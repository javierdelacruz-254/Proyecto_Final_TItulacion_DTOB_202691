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

  // Personales
  bool _tbc = false;
  bool _diabetes = false;
  bool _hipertension = false;
  bool _cirugiaPelvica = false;
  bool _infertilidad = false;
  bool _anemia = false;
  bool _epilepsia = false;
  bool _cardiopatia = false;
  final _otrosController = TextEditingController();

  // Familiares
  bool _tbcFamiliar = false;
  bool _diabetesFamiliar = false;
  bool _hipertensionFamiliar = false;
  final _otrosFamiliarController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.perfilMedicoModel;

    if (model != null) {
      _tbc = model.tbc;
      _diabetes = model.diabetes;
      _hipertension = model.hipertension;
      _cirugiaPelvica = model.cirugiaPelvica;
      _infertilidad = model.infertilidad;
      _anemia = model.anemia;
      _epilepsia = model.epilepsia;
      _cardiopatia = model.cardiopatia;
      _otrosController.text = model.otros ?? "";

      _tbcFamiliar = model.tbcFamiliar;
      _diabetesFamiliar = model.diabetesFamiliar;
      _hipertensionFamiliar = model.hipertensionFamiliar;
      _otrosFamiliarController.text = model.otrosFamiliar ?? "";
    }
  }

  @override
  void dispose() {
    _otrosController.dispose();
    _otrosFamiliarController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = PerfilMedicoModel(
      tbc: _tbc,
      diabetes: _diabetes,
      hipertension: _hipertension,
      cirugiaPelvica: _cirugiaPelvica,
      infertilidad: _infertilidad,
      anemia: _anemia,
      epilepsia: _epilepsia,
      cardiopatia: _cardiopatia,
      otros: _otrosController.text.isEmpty
          ? null
          : _otrosController.text.trim(),
      tbcFamiliar: _tbcFamiliar,
      diabetesFamiliar: _diabetesFamiliar,
      hipertensionFamiliar: _hipertensionFamiliar,
      otrosFamiliar: _otrosFamiliarController.text.isEmpty
          ? null
          : _otrosFamiliarController.text.trim(),
    );

    ref.read(registerViewModelProvider.notifier).setPerfilMedico(model);

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
              "Perfil Médico",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            _sectionTitle("Antecedentes Personales"),
            _buildCheckbox("TBC", _tbc, (v) => _tbc = v),
            _buildCheckbox("Diabetes", _diabetes, (v) => _diabetes = v),
            _buildCheckbox(
              "Hipertensión",
              _hipertension,
              (v) => _hipertension = v,
            ),
            _buildCheckbox(
              "Cirugía pélvica",
              _cirugiaPelvica,
              (v) => _cirugiaPelvica = v,
            ),
            _buildCheckbox(
              "Infertilidad",
              _infertilidad,
              (v) => _infertilidad = v,
            ),
            _buildCheckbox("Anemia", _anemia, (v) => _anemia = v),
            _buildCheckbox("Epilepsia", _epilepsia, (v) => _epilepsia = v),
            _buildCheckbox(
              "Cardiopatía",
              _cardiopatia,
              (v) => _cardiopatia = v,
            ),

            _buildTextField("Otros (opcional)", _otrosController),

            const SizedBox(height: 24),

            _sectionTitle("Antecedentes Familiares"),
            _buildCheckbox(
              "TBC Familiar",
              _tbcFamiliar,
              (v) => _tbcFamiliar = v,
            ),
            _buildCheckbox(
              "Diabetes Familiar",
              _diabetesFamiliar,
              (v) => _diabetesFamiliar = v,
            ),
            _buildCheckbox(
              "Hipertensión Familiar",
              _hipertensionFamiliar,
              (v) => _hipertensionFamiliar = v,
            ),

            _buildTextField(
              "Otros antecedentes familiares (opcional)",
              _otrosFamiliarController,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
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
