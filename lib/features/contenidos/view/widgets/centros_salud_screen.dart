import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lactaamor/core/constants/centros_mock_data.dart';
import 'package:lactaamor/features/home/models/centro_salud_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/centro_detalle_screen.dart';

enum OrdenCentro { nombre, distancia }

class CentrosSaludScreen extends StatefulWidget {
  const CentrosSaludScreen({super.key});

  @override
  State<CentrosSaludScreen> createState() => _CentrosSaludScreenState();
}

class _CentrosSaludScreenState extends State<CentrosSaludScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _filtroTipo = '';
  OrdenCentro _orden = OrdenCentro.nombre;
  Position? _posicionActual;
  bool _cargandoUbicacion = true;

  // Tipos únicos para los chips de filtro
  List<String> get _tiposUnicos {
    final tipos = listaCentros.map((c) => c.tipo).toSet().toList();
    tipos.sort();
    return tipos;
  }

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  Future<void> _obtenerUbicacion() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _cargandoUbicacion = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _cargandoUbicacion = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _cargandoUbicacion = false);
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _posicionActual = pos;
        _cargandoUbicacion = false;
      });
    } catch (_) {
      setState(() => _cargandoUbicacion = false);
    }
  }

  double? _calcularDistancia(CentroSalud centro) {
    if (_posicionActual == null) return null;
    // Fórmula Haversine simplificada
    const R = 6371.0; // km
    final lat1 = _posicionActual!.latitude * pi / 180;
    final lat2 = centro.lat * pi / 180;
    final dLat = (centro.lat - _posicionActual!.latitude) * pi / 180;
    final dLng = (centro.lng - _posicionActual!.longitude) * pi / 180;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  String _formatearDistancia(double? km) {
    if (km == null) return '';
    if (km < 1) return '${(km * 1000).round()} m';
    return '${km.toStringAsFixed(1)} km';
  }

  List<CentroSalud> get _centrosFiltradosYOrdenados {
    final q = _query.toLowerCase();

    var filtrados = listaCentros.where((c) {
      final coincideQuery = q.isEmpty ||
          c.nombre.toLowerCase().contains(q) ||
          c.distrito.toLowerCase().contains(q) ||
          c.tipo.toLowerCase().contains(q) ||
          c.servicios.any((s) => s.toLowerCase().contains(q));

      final coincideTipo = _filtroTipo.isEmpty || c.tipo == _filtroTipo;

      return coincideQuery && coincideTipo;
    }).toList();

    // Ordenar
    if (_orden == OrdenCentro.distancia && _posicionActual != null) {
      filtrados.sort((a, b) {
        final dA = _calcularDistancia(a) ?? double.infinity;
        final dB = _calcularDistancia(b) ?? double.infinity;
        return dA.compareTo(dB);
      });
    } else {
      filtrados.sort((a, b) => a.nombre.compareTo(b.nombre));
    }

    return filtrados;
  }

  Color _colorPorTipo(String tipo) {
    switch (tipo) {
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

  IconData _iconoPorTipo(String tipo) {
    switch (tipo) {
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

  @override
  Widget build(BuildContext context) {
    final centros = _centrosFiltradosYOrdenados;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      body: CustomScrollView(
        slivers: [
          // ── AppBar con buscador ──────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF7B5EA7),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text(
                'Centros de Salud',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9C6FD6), Color(0xFF5E3F8F)],
                  ),
                ),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 60, right: 16),
                    child: Icon(
                      Icons.local_hospital_rounded,
                      size: 80,
                      color: Colors.white12,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Buscador + Filtros (sticky) ──────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(
              child: _buildSearchAndFilters(),
            ),
          ),

          // ── Contador + Orden ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${centros.length} centro${centros.length != 1 ? 's' : ''} encontrado${centros.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // Chips de orden
                  _buildOrdenChip(OrdenCentro.nombre, 'A-Z', Icons.sort_by_alpha_rounded),
                  const SizedBox(width: 6),
                  _buildOrdenChip(
                    OrdenCentro.distancia,
                    'Distancia',
                    Icons.near_me_rounded,
                    disabled: _posicionActual == null,
                  ),
                ],
              ),
            ),
          ),

          // ── Estado de ubicación ──────────────────────────────────
          if (_cargandoUbicacion)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Obteniendo tu ubicación...',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),

          // ── Lista de centros ──────────────────────────────────────
          centros.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildCentroCard(centros[index]),
                      childCount: centros.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: const Color(0xFFF8F4FF),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Buscador
          TextField(
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, distrito, tipo o servicio…',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
              prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF7B5EA7)),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFF7B5EA7), width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 8),
          // Chips de tipo
          SizedBox(
            height: 34,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTipoChip('', 'Todos'),
                ..._tiposUnicos.map((t) => _buildTipoChip(t, t)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipoChip(String valor, String label) {
    final seleccionado = _filtroTipo == valor;
    final color = valor.isEmpty ? const Color(0xFF7B5EA7) : _colorPorTipo(valor);
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: FilterChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: seleccionado,
        onSelected: (_) => setState(() => _filtroTipo = valor),
        selectedColor: color.withOpacity(0.15),
        checkmarkColor: color,
        labelStyle: TextStyle(
          color: seleccionado ? color : Colors.grey[600],
          fontWeight: seleccionado ? FontWeight.bold : FontWeight.normal,
        ),
        side: BorderSide(color: seleccionado ? color : Colors.grey.shade300),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildOrdenChip(
    OrdenCentro orden,
    String label,
    IconData icon, {
    bool disabled = false,
  }) {
    final seleccionado = _orden == orden;
    return GestureDetector(
      onTap: disabled ? null : () => setState(() => _orden = orden),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(0xFF7B5EA7)
              : disabled
                  ? Colors.grey.shade100
                  : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: seleccionado
                ? const Color(0xFF7B5EA7)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: seleccionado
                  ? Colors.white
                  : disabled
                      ? Colors.grey.shade400
                      : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: seleccionado
                    ? Colors.white
                    : disabled
                        ? Colors.grey.shade400
                        : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentroCard(CentroSalud centro) {
    final distancia = _calcularDistancia(centro);
    final color = _colorPorTipo(centro.tipo);
    final icono = _iconoPorTipo(centro.tipo);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CentroDetalleScreen(centro: centro),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                // Barra lateral de color + ícono
                Container(
                  width: 64,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icono, color: color, size: 28),
                      if (distancia != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          _formatearDistancia(distancia),
                          style: TextStyle(
                            fontSize: 10,
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                // Contenido
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge tipo
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            centro.tipo,
                            style: TextStyle(
                              fontSize: 10,
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          centro.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.place_rounded,
                                size: 12, color: Colors.grey[400]),
                            const SizedBox(width: 2),
                            Text(
                              centro.distrito,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Servicios (máx. 2)
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: centro.servicios
                              .take(2)
                              .map(
                                (s) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                            ..addAll(
                              centro.servicios.length > 2
                                  ? [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '+${centro.servicios.length - 2}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [],
                            ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Flecha
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No se encontraron centros',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Intenta con otro término o filtro',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// ── Delegate para el header sticky ──────────────────────────────────────────
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _SearchHeaderDelegate({required this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 106;
  @override
  double get minExtent => 106;
  @override
  bool shouldRebuild(_SearchHeaderDelegate old) => true;
}