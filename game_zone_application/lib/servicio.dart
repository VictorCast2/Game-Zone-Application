import 'package:flutter/material.dart';

void main() {
  runApp(const ServicioPage());
}

class ServicioPage extends StatelessWidget {
  const ServicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone - Servicios',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050017), // mismo fondo oscuro
        primaryColor: Colors.purpleAccent,
      ),
      home: const ServiciosScreen(),
    );
  }
}

class ServiciosScreen extends StatelessWidget {
  const ServiciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: const Color(0xFF0A0021),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.videogame_asset_rounded,
                      color: Colors.purpleAccent),
                  SizedBox(width: 8),
                  Text(
                    "GameZone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  _NavButton("Inicio"),
                  _NavButton("Catálogo"),
                  _NavButton("Ofertas"),
                  _NavButton("Noticias"),
                  _NavButton("Contacto"),
                  _NavButton("Servicios", isActive: true),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Título principal
            const Text(
              "Nuestros Servicios",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Explora todo lo que tenemos para ofrecerte en GameZone",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 50),

            // Secciones
            _serviceCard(
              icon: Icons.shopping_cart_outlined,
              title: "Venta de videojuegos nuevos",
              description:
                  "Encuentra los últimos lanzamientos y clásicos imperdibles. Disfruta de una experiencia de compra fácil, rápida y segura.",
            ),
            _serviceCard(
              icon: Icons.event_available_outlined,
              title: "Reservas de lanzamientos",
              description:
                  "Asegura tus títulos favoritos antes de su lanzamiento y recibe beneficios exclusivos al reservar en GameZone.",
            ),
            _serviceCard(
              icon: Icons.card_membership_outlined,
              title: "Membresías y programas de lealtad",
              description:
                  "Obtén recompensas por cada compra, descuentos especiales y acceso anticipado a eventos exclusivos de la comunidad.",
            ),
            _serviceCard(
              icon: Icons.card_giftcard_outlined,
              title: "Gift cards y tarjetas de regalo",
              description:
                  "Regala diversión con nuestras tarjetas digitales. Perfectas para sorprender a cualquier amante de los videojuegos.",
            ),

            const SizedBox(height: 80),

            // Sección final creativa
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF150050), Color(0xFF050017)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "GameZone Experience",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Más que una tienda, una comunidad gamer.\n"
                    "Descubre. Conecta. Juega sin límites.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "ÚNETE AHORA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "© 2025 GameZone. Todos los derechos reservados.",
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- Widgets personalizados -----

  static Widget _serviceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0035),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(18),
            child: Icon(icon, size: 36, color: Colors.purpleAccent),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final bool isActive;
  const _NavButton(this.text, {this.isActive = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.purpleAccent : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }
}
