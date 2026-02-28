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

  final _direccionController = TextEditingController();
  final _educacionAprobadosController = TextEditingController();
  final _grupoSangreController = TextEditingController();
  final _ocupacionController = TextEditingController();
  final _seguroController = TextEditingController();

  EstadoCivil? _estadoCivil;
  NivelEducacion? _nivelEducacion;
  RhSangre? _rh;
  bool _sabeLeer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.perfilMaternoModel;

    if (model != null) {
      _direccionController.text = model.direccion;
      _educacionAprobadosController.text =
          model.educacionAprobados?.toString() ?? "";
      _grupoSangreController.text = model.grupoSangre;
      _ocupacionController.text = model.ocupacion ?? "";
      _seguroController.text = model.seguroSalud ?? "";

      _estadoCivil = model.estadoCivil;
      _nivelEducacion = model.nivelEducacion;
      _rh = model.rh;
      _sabeLeer = model.sabeLeer;
    }
  }

  @override
  void dispose() {
    _direccionController.dispose();
    _educacionAprobadosController.dispose();
    _grupoSangreController.dispose();
    _ocupacionController.dispose();
    _seguroController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = PerfilMaternoModel(
      estadoCivil: _estadoCivil!,
      direccion: _direccionController.text.trim(),
      nivelEducacion: _nivelEducacion!,
      educacionAprobados: _educacionAprobadosController.text.isEmpty
          ? null
          : int.parse(_educacionAprobadosController.text.trim()),
      sabeLeer: _sabeLeer,
      grupoSangre: _grupoSangreController.text.trim(),
      rh: _rh!,
      ocupacion: _ocupacionController.text.trim().isEmpty
          ? null
          : _ocupacionController.text.trim(),
      seguroSalud: _seguroController.text.trim().isEmpty
          ? null
          : _seguroController.text.trim(),
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
            _buildTextField("Dirección", _direccionController),
            _buildDropdownNivelEducacion(),
            _buildTextField(
              "Años aprobados (opcional)",
              _educacionAprobadosController,
              keyboardType: TextInputType.number,
              required: false,
            ),
            _buildCheckbox(),
            _buildTextField(
              "Grupo sanguíneo (Ej: A, B, AB, O)",
              _grupoSangreController,
            ),
            _buildDropdownRh(),
            _buildTextField(
              "Ocupación (opcional)",
              _ocupacionController,
              required: false,
            ),
            _buildTextField(
              "Seguro de salud (opcional)",
              _seguroController,
              required: false,
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
        initialValue: _estadoCivil,
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

  Widget _buildDropdownNivelEducacion() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<NivelEducacion>(
        initialValue: _nivelEducacion,
        decoration: const InputDecoration(labelText: "Nivel Educativo"),
        items: NivelEducacion.values
            .map(
              (e) =>
                  DropdownMenuItem(value: e, child: Text(e.name.toUpperCase())),
            )
            .toList(),
        onChanged: (value) => setState(() => _nivelEducacion = value),
        validator: (value) => value == null ? "Campo obligatorio" : null,
      ),
    );
  }

  Widget _buildDropdownRh() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<RhSangre>(
        initialValue: _rh,
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

  Widget _buildCheckbox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CheckboxListTile(
        value: _sabeLeer,
        onChanged: (value) => setState(() => _sabeLeer = value ?? false),
        title: const Text("¿Sabe leer y escribir?"),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (!required) return null;
          if (value == null || value.isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        },
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
