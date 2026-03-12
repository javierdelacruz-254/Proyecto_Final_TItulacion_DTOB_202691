import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lactaamor/features/home/models/centro_salud_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CentroDetalleScreen extends StatefulWidget {
  final CentroSalud centro;

  const CentroDetalleScreen({super.key, required this.centro});

  @override
  State<CentroDetalleScreen> createState() => _CentroDetalleScreenState();
}

class _CentroDetalleScreenState extends State<CentroDetalleScreen> {
  bool _mapaCargado = false;

  // ── Colores por tipo (coherencia con la lista) ───────────────────
  Color get _colorTipo {
    switch (widget.centro.tipo) {
      case 'Hospital':
        return const Color(0xFFD32F2F);
      case 'Centro de Salud':
        return const Color(0xFF388E3C);
      case 'Clínica':
        return const Color(0xFF1565C0);
      default:
        return const Color(0xFF6D4C41);
    }
  }

  IconData get _iconoTipo {
    switch (widget.centro.tipo) {
      case 'Hospital':
        return Icons.local_hospital_rounded;
      case 'Centro de Salud':
        return Icons.health_and_safety_rounded;
      case 'Clínica':
        return Icons.medical_services_rounded;
      default:
        return Icons.place_rounded;
    }
  }

  // ── Acciones ────────────────────────────────────────────────────
  Future<void> _abrirMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&destination=${widget.centro.lat},${widget.centro.lng}',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _mostrarError('No se pudo abrir Google Maps');
    }
  }

  Future<void> _abrirWhatsApp() async {
    final telefono = widget.centro.telefono.replaceAll(RegExp(r'\D'), '');
    if (telefono.isEmpty) {
      _mostrarError('Número de WhatsApp no disponible');
      return;
    }
    final uri = Uri.parse('https://wa.me/$telefono');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _mostrarError('No se pudo abrir WhatsApp');
    }
  }

  Future<void> _llamar() async {
    final telefono = widget.centro.telefono.replaceAll(RegExp(r'\D'), '');
    if (telefono.isEmpty) {
      _mostrarError('Número de teléfono no disponible');
      return;
    }
    final uri = Uri.parse('tel:+$telefono');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _mostrarError('No se pudo realizar la llamada');
    }
  }

  void _copiarTelefono() {
    Clipboard.setData(ClipboardData(text: widget.centro.telefono));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Número copiado al portapapeles'),
          ],
        ),
        backgroundColor: _colorTipo,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(mensaje),
          ],
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.centro;
    final posicion = LatLng(c.lat, c.lng);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      body: CustomScrollView(
        slivers: [
          // ── Header con gradiente ──────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: _colorTipo,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
              title: Text(
                c.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _colorTipo.withOpacity(0.8),
                      _colorTipo,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Icon(_iconoTipo, size: 72, color: Colors.white24),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        c.tipo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Tarjeta de info básica ──────────────────────
                  _buildCard(
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.place_rounded,
                          label: 'Dirección',
                          value: c.direccion,
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          icon: Icons.location_city_rounded,
                          label: 'Distrito',
                          value: c.distrito,
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          icon: Icons.schedule_rounded,
                          label: 'Horario',
                          value: c.horario,
                          valueColor: Colors.green[700],
                        ),
                        _buildDivider(),
                        // Teléfono copiable
                        InkWell(
                          onTap: _copiarTelefono,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.phone_rounded,
                                    color: _colorTipo, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Teléfono',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '+${c.telefono}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.copy_rounded,
                                    size: 16, color: Colors.grey[400]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Servicios ────────────────────────────────────
                  _buildSectionTitle('Servicios disponibles'),
                  const SizedBox(height: 10),
                  _buildCard(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: c.servicios.map((s) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: _colorTipo.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: _colorTipo.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_rounded,
                                  size: 14, color: _colorTipo),
                              const SizedBox(width: 6),
                              Text(
                                s,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _colorTipo,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Botones de acción ────────────────────────────
                  _buildSectionTitle('Contacto y ubicación'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.phone_rounded,
                          label: 'Llamar',
                          onTap: _llamar,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.chat_rounded,
                          label: 'WhatsApp',
                          onTap: _abrirWhatsApp,
                          color: const Color(0xFF00897B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.directions_rounded,
                          label: 'Cómo llegar',
                          onTap: _abrirMaps,
                          color: const Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Mapa ─────────────────────────────────────────
                  _buildSectionTitle('Ubicación'),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 220,
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: posicion,
                              zoom: 15,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId('centro'),
                                position: posicion,
                                infoWindow: InfoWindow(title: c.nombre),
                              ),
                            },
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            onMapCreated: (_) =>
                                setState(() => _mapaCargado = true),
                          ),
                          if (!_mapaCargado)
                            Container(
                              color: Colors.grey[100],
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                        color: _colorTipo),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Cargando mapa…',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
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

  // ── Helpers de UI ────────────────────────────────────────────────

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _colorTipo, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? const Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(
        height: 1,
        color: Colors.grey.shade100,
        indent: 32,
      );

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}