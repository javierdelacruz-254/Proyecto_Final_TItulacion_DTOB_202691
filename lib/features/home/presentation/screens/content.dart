import 'package:flutter/material.dart';
import 'package:lactaamor/features/home/data/contenido_data.dart';
import 'package:lactaamor/features/home/models/contenido_model.dart';
import 'package:lactaamor/features/home/presentation/screens/lista_articulos_screen.dart';

class ContenidoScreen extends StatelessWidget {
  const ContenidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= LACTANCIA =================
            _sectionTitle("Lactancia"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Consejos básicos",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_oqtdm8.jpg",
              ),
              _ContentCard(
                title: "Problemas comunes",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/images_1_axk2io.jpg",
              ),
              _ContentCard(
                title: "Extracción y conservación",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547695/000987235W_x0wd7m.webp",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= RECIÉN NACIDO =================
            _sectionTitle("Cuidados del Recién Nacido"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Baño del bebé",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547866/images_2_w5irep.jpg",
              ),
              _ContentCard(
                title: "Sueño seguro",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547867/A92_omwrsm.webp",
              ),
              _ContentCard(
                title: "Cambio de pañal",
                imageUrl:
                    "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547866/images_3_nbcj75.jpg",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= RECETAS =================
            _sectionTitle("Recetas Peruanas"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Recetas para Mamá",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547939/photo-1546069901-ba9599a7e63c_ru66vp.jpg",
              ),
              _ContentCard(
                title: "Papillas nutritivas",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_4_s47wfh.jpg",
              ),
              _ContentCard(
                title: "Alimentos ricos en hierro",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771547938/images_5_s24o70.jpg",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= SALUD DEL BEBÉ =================
            _sectionTitle("Salud del Bebé"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Calendario de vacunas",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548015/images_6_oxn9kf.jpg",
              ),
              _ContentCard(
                title: "Señales de alerta",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548015/62a9036b841b7.r_d.572-437-3925_pwtuu4.jpg",
              ),
              _ContentCard(
                title: "Control pediátrico",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548015/images_7_x90qph.jpg",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= SALUD EMOCIONAL =================
            _sectionTitle("Bienestar Emocional"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Depresión postparto",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548120/como-reconocer-depresion-post-parto-2_zvkiq5.jpg",
              ),
              _ContentCard(
                title: "Autocuidado para mamá",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548120/images_8_bl2uef.jpg",
              ),
              _ContentCard(
                title: "Manejo del estrés",
                imageUrl: "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771548120/images_9_ydb2i9.jpg",
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ================= TÍTULO =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= LISTA HORIZONTAL =================
  Widget _buildHorizontalCards(List<Widget> cards) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) => cards[index],
      ),
    );
  }
}

// ================= TARJETA =================

class _ContentCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _ContentCard({
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        final TemaContenido? temaSeleccionado = todosLosTemas
            .where((tema) => tema.titulo == title)
            .firstOrNull;

        if (temaSeleccionado == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Contenido no disponible aún"),
            ),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListaArticulosScreen(
              tema: temaSeleccionado,
            ),
          ),
        );
      },
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =================EXTENSIÓN PARA evitar error firstWhere =================
extension FirstOrNullExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}