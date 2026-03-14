import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/perfil/viewmodel/perfil_state.dart';
import 'package:lactaamor/features/perfil/viewmodel/perfil_viewmodel.dart';

class CuentaScreen extends ConsumerStatefulWidget {
  const CuentaScreen({super.key});

  @override
  ConsumerState<CuentaScreen> createState() => _CuentaScreenState();
}

class _CuentaScreenState extends ConsumerState<CuentaScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  String? _expandedSection;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(homeViewModelProvider).profile;
    final authUser = ref.read(authViewModelProvider).user;
    _nameController.text = profile?.fullname ?? authUser?.fullname ?? '';
    _emailController.text = authUser?.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleSection(String section) {
    setState(() {
      _expandedSection = _expandedSection == section ? null : section;
    });
  }

  // Reacciona al estado del viewmodel para mostrar snackbar
  void _handleStateChange(PerfilState? prev, PerfilState next) {
    if (next.successMessage != null) {
      _showSnack(next.successMessage!);
      setState(() => _expandedSection = null);
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      ref.read(perfilViewModelProvider.notifier).clearMessages();
    }
    if (next.error != null) {
      _showSnack(next.error!, isError: true);
      ref.read(perfilViewModelProvider.notifier).clearMessages();
    }
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escucha cambios del viewmodel para mostrar feedback
    ref.listen(perfilViewModelProvider, _handleStateChange);

    final perfilState = ref.watch(perfilViewModelProvider);
    final profile = ref.watch(homeViewModelProvider).profile;
    final authUser = ref.watch(authViewModelProvider).user;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).padding.bottom + 80,
        ),
        child: Column(
          children: [
            // ── Avatar ───────────────────────────────────────────
            _AvatarSection(
              fullname: profile?.fullname ?? authUser?.fullname ?? 'Sin nombre',
              email: authUser?.email ?? '',
              photo: authUser?.photo,
            ),

            const SizedBox(height: 24),

            // ── Info del perfil (solo lectura) ───────────────────
            if (profile != null) ...[
              _InfoCard(
                title: 'Mi perfil',
                icon: Icons.person_outline,
                isDark: isDark,
                children: [
                  if ([
                    profile.distrito,
                    profile.provincia,
                    profile.departamento,
                  ].any((e) => e != null && e.isNotEmpty))
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Ubicación',
                      value: [
                        profile.distrito,
                        profile.provincia,
                        profile.departamento,
                      ].where((e) => e != null && e.isNotEmpty).join(', '),
                    ),
                  if (profile.edad != null)
                    _InfoRow(
                      icon: Icons.cake_outlined,
                      label: 'Edad',
                      value: '${profile.edad} años',
                    ),
                  if (profile.celular != null)
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Celular',
                      value: profile.celular!,
                    ),
                  _InfoRow(
                    icon: Icons.pregnant_woman,
                    label: 'Estado',
                    value: profile.haDadoLuz ? 'Postparto' : 'Embarazada',
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (profile.fechaNacimientoBebe != null ||
                  profile.peso != null ||
                  profile.sexoBebe != null)
                _InfoCard(
                  title: 'Mi bebé',
                  icon: Icons.child_care,
                  isDark: isDark,
                  children: [
                    if (profile.sexoBebe != null)
                      _InfoRow(
                        icon: profile.sexoBebe == 'masculino'
                            ? Icons.boy
                            : Icons.girl,
                        label: 'Sexo',
                        value: profile.sexoBebe == 'masculino'
                            ? 'Niño 👦'
                            : 'Niña 👧',
                      ),
                    if (profile.fechaNacimientoBebe != null)
                      _InfoRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Edad del bebé',
                        value:
                            '${profile.semanasPostParto} semanas (${profile.diasPostParto} días)',
                      ),
                    if (profile.peso != null)
                      _InfoRow(
                        icon: Icons.monitor_weight_outlined,
                        label: 'Peso al nacer',
                        value: '${profile.peso} kg',
                      ),
                    if (profile.altura != null)
                      _InfoRow(
                        icon: Icons.straighten,
                        label: 'Talla al nacer',
                        value: '${profile.altura} cm',
                      ),
                    if (profile.tipoParto != null)
                      _InfoRow(
                        icon: Icons.local_hospital_outlined,
                        label: 'Tipo de parto',
                        value: profile.tipoParto!,
                      ),
                    _InfoRow(
                      icon: Icons.water_drop_outlined,
                      label: 'Lactancia exclusiva',
                      value: profile.lactanciaMaterna == true ? 'Sí ✅' : 'No',
                    ),
                  ],
                ),

              const SizedBox(height: 24),
            ],

            // ── Editar nombre ────────────────────────────────────
            _EditSection(
              title: 'Nombre completo',
              icon: Icons.edit_outlined,
              isExpanded: _expandedSection == 'name',
              onToggle: () => _toggleSection('name'),
              currentValue: profile?.fullname ?? authUser?.fullname ?? '',
              child: Column(
                children: [
                  _StyledTextField(
                    controller: _nameController,
                    label: 'Nombre completo',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 12),
                  _SaveButton(
                    isLoading: perfilState.isLoading,
                    onPressed: () => ref
                        .read(perfilViewModelProvider.notifier)
                        .updateName(_nameController.text),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Cambiar correo ───────────────────────────────────
            _EditSection(
              title: 'Correo electrónico',
              icon: Icons.email_outlined,
              isExpanded: _expandedSection == 'email',
              onToggle: () => _toggleSection('email'),
              currentValue: authUser?.email ?? '',
              child: Column(
                children: [
                  _StyledTextField(
                    controller: _emailController,
                    label: 'Nuevo correo',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _StyledTextField(
                    controller: _currentPasswordController,
                    label: 'Contraseña actual (requerida)',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    showPassword: _showCurrentPassword,
                    onTogglePassword: () => setState(
                      () => _showCurrentPassword = !_showCurrentPassword,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '📧 Te enviaremos un correo de verificación',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  _SaveButton(
                    isLoading: perfilState.isLoading,
                    onPressed: () => ref
                        .read(perfilViewModelProvider.notifier)
                        .updateEmail(
                          _emailController.text,
                          _currentPasswordController.text,
                        ),
                    label: 'Actualizar correo',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Cambiar contraseña ───────────────────────────────
            _EditSection(
              title: 'Contraseña',
              icon: Icons.lock_outline,
              isExpanded: _expandedSection == 'password',
              onToggle: () => _toggleSection('password'),
              currentValue: '••••••••',
              child: Column(
                children: [
                  _StyledTextField(
                    controller: _currentPasswordController,
                    label: 'Contraseña actual',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    showPassword: _showCurrentPassword,
                    onTogglePassword: () => setState(
                      () => _showCurrentPassword = !_showCurrentPassword,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _StyledTextField(
                    controller: _newPasswordController,
                    label: 'Nueva contraseña',
                    icon: Icons.lock_open_outlined,
                    isPassword: true,
                    showPassword: _showNewPassword,
                    onTogglePassword: () =>
                        setState(() => _showNewPassword = !_showNewPassword),
                  ),
                  const SizedBox(height: 12),
                  _StyledTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmar nueva contraseña',
                    icon: Icons.lock_open_outlined,
                    isPassword: true,
                    showPassword: _showConfirmPassword,
                    onTogglePassword: () => setState(
                      () => _showConfirmPassword = !_showConfirmPassword,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SaveButton(
                    isLoading: perfilState.isLoading,
                    onPressed: () => ref
                        .read(perfilViewModelProvider.notifier)
                        .updatePassword(
                          currentPassword: _currentPasswordController.text,
                          newPassword: _newPasswordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        ),
                    label: 'Cambiar contraseña',
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

// ─── Widgets privados — solo UI, sin lógica ──────────────────────────────────

class _AvatarSection extends StatelessWidget {
  final String fullname;
  final String email;
  final String? photo;
  const _AvatarSection({
    required this.fullname,
    required this.email,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    final initials = fullname.trim().isNotEmpty
        ? fullname
              .trim()
              .split(' ')
              .map((e) => e[0])
              .take(2)
              .join()
              .toUpperCase()
        : '?';

    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          backgroundImage: photo != null ? NetworkImage(photo!) : null,
          child: photo == null
              ? Text(
                  initials,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                )
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          fullname,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool isDark;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onToggle;
  final String currentValue;
  final Widget child;
  const _EditSection({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onToggle,
    required this.currentValue,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(icon, color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          currentValue,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
            ),
        ],
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool showPassword;
  final VoidCallback? onTogglePassword;
  final TextInputType? keyboardType;
  const _StyledTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.showPassword = false,
    this.onTogglePassword,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !showPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;
  const _SaveButton({
    required this.isLoading,
    required this.onPressed,
    this.label = 'Guardar cambios',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
