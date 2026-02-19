import 'package:flutter/material.dart';

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
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQySqRdnsl-iS1r4gY2N6BNzStmYasYRvju1g&s",
              ),
              _ContentCard(
                title: "Problemas comunes",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRluTLPlDNjsWFC-Cs4zyHcrQtVD-wEhVgwuw&s",
              ),
              _ContentCard(
                title: "Extracción y conservación",
                imageUrl: "https://portal.andina.pe/EDPfotografia3/Thumbnail/2023/08/21/000987235W.webp",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= RECIÉN NACIDO =================
            _sectionTitle("Cuidados del Recién Nacido"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Baño del bebé",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8CqdOx29xXkx5BT-6qULkD1viHb0peBq9Rg&s",
              ),
              _ContentCard(
                title: "Sueño seguro",
                imageUrl: "https://images.ctfassets.net/2ql69mthp94m/4U3jg5tp3IatqB3lEwIbJq/4a001959af1d8b271aa746ae35067e0e/A92.jpeg?fm=webp&q=70",
              ),
              _ContentCard(
                title: "Cambio de pañal",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8-N94uUyorgJkJ8b9BPIVRurWbZLGe_DzVA&s",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= RECETAS =================
            _sectionTitle("Recetas Peruanas"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Recetas para Mamá",
                imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
              ),
              _ContentCard(
                title: "Papillas nutritivas",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJKKhQ0sXcpqN9TApWLezB4tEY5XzFnA8iOQ&s",
              ),
              _ContentCard(
                title: "Alimentos ricos en hierro",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDpUQvMS8ANfNV4k17OYsaEMP9l-NsfJ1Umg&s",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= SALUD DEL BEBÉ =================
            _sectionTitle("Salud del Bebé"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Calendario de vacunas",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzDhJ8Nhr3T3ZD--kZz0X9c2cvoyZDLH_l_A&s",
              ),
              _ContentCard(
                title: "Señales de alerta",
                imageUrl: "https://www.lavanguardia.com/files/image_449_220/files/fp/uploads/2022/06/14/62a9036b841b7.r_d.572-437-3925.jpeg",
              ),
              _ContentCard(
                title: "Control pediátrico",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSXCSIoplpoLRR0FkGSRIP4np3290_soIX2Q&s",
              ),
            ]),

            const SizedBox(height: 28),

            // ================= SALUD EMOCIONAL =================
            _sectionTitle("Bienestar Emocional"),
            _buildHorizontalCards([
              _ContentCard(
                title: "Depresión postparto",
                imageUrl: "https://blog.auna.pe/hubfs/Imported_Blog_Media/como-reconocer-depresion-post-parto-2.jpg",
              ),
              _ContentCard(
                title: "Autocuidado para mamá",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7RojD4RCqU3Oja72R8R8cmhBxXsgyPC7Djw&s",
              ),
              _ContentCard(
                title: "Manejo del estrés",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbP7L68J4s5e_bcaEU_-bu1-Hm_tF6JeuM5w&s",
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ================= WIDGET TÍTULO =================
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

  // ================= SCROLL HORIZONTAL =================
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
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
