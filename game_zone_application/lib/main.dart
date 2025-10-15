import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(GameZoneApp());
}

class GameZoneApp extends StatelessWidget {
  const GameZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF020024),
        primaryColor: const Color(0xFF8A12E6),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // 🔁 Configura el tiempo de cambio automático del carrusel
  final Duration _autoSlideDuration = const Duration(seconds: 4);

  // 🎮 Lista de juegos con imágenes y descripción
  final List<Map<String, String>> _slides = [
    {
      "image":
          "https://i.pinimg.com/736x/2b/02/f0/2b02f09dda89cfbef21b7bc3eea90fc4.jpg",
      "title": "Fortnite OG",
      "description": "Revive los momentos clásicos en la isla original.",
    },
    {
      "image":
          "https://i.pinimg.com/1200x/9a/2c/1c/9a2c1c428752523b0a8c6a5cb65a386e.jpg",
      "title": "GTA V",
      "description": "Explora Los Santos con total libertad.",
    },
    {
      "image":
          "https://i.pinimg.com/1200x/0b/ea/3b/0bea3b30b35c95412b8f9940b210bc85.jpg",
      "title": "Resident Evil 4 Remake",
      "description": "Terror clásico reinventado por Capcom.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/x8VxQb6v2QhXz5U6rHtT5D.jpg",
      "title": "Red Dead Redemption 2",
      "description":
          "Vive el salvaje oeste con Arthur Morgan y la banda de Van der Linde.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/XaZxqDbAzxDqDdC9yRk4jK.jpg",
      "title": "Cyberpunk 2077",
      "description":
          "Explora Night City y define tu destino como V, un mercenario cibernético.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/3oXvXZs9gHZdukpYjGm6T7.jpg",
      "title": "Hollow Knight",
      "description":
          "Una aventura oscura y hermosa bajo tierra llena de misterio y acción.",
    },
    {
      "image": "https://i.ytimg.com/vi/Ekx2rH5lS3Q/maxresdefault.jpg",
      "title": "Buckshot Roulette",
      "description":
          "Juega a la ruleta rusa con un giro sangriento y psicológico.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/dvQEPQ9dKK5rKfQ2bf89pA.jpg",
      "title": "The Forest",
      "description":
          "Sobrevive en una isla llena de secretos, caníbales y terror psicológico.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/QACaZpA6D9gGJ3t5MPD7C5.jpg",
      "title": "God of War Ragnarök",
      "description":
          "Acompaña a Kratos y Atreus en su épico viaje por los reinos nórdicos.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/QFy2sRCBGp7ZtZgMufr9E5.jpg",
      "title": "Elden Ring",
      "description":
          "Explora un vasto mundo abierto creado por FromSoftware y George R. R. Martin.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/dMCsM6m7kMGnb5Y6uq3nFL.jpg",
      "title": "The Last of Us Part I",
      "description":
          "Una historia intensa de supervivencia, amor y redención en un mundo postapocalíptico.",
    },
    {
      "image":
          "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2025/01/assassins-creed-shadows-samurai-yasuke-naoe.jpg",
      "title": "Assassin’s Creed Shadows",
      "description":
          "Explora el Japón feudal como samurái o ninja en esta épica entrega de Ubisoft.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/6f8C4s3PgH3Vp9e9u6mPTb.jpg",
      "title": "Monster Hunter Wilds",
      "description":
          "Caza bestias colosales en un vasto mundo abierto con un ecosistema dinámico.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/ZiTwCNGV8uv2HBF7vAykGZ.jpg",
      "title": "Final Fantasy VII Rebirth",
      "description":
          "Continúa la historia de Cloud y sus amigos en una reimaginación espectacular del clásico.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/eTpkWRPR8xQ6qRk6BFAwBT.jpg",
      "title": "Senua’s Saga: Hellblade II",
      "description":
          "Una experiencia cinematográfica con gráficos de nueva generación y narrativa intensa.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/a4N5BwnZSR4GvVUnZDbtKc.jpg",
      "title": "Silent Hill F",
      "description":
          "Terror psicológico ambientado en el Japón de los años 60, con una atmósfera inquietante.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/L7vxPP7Pw6JxWwYYehkqW4.jpg",
      "title": "Hades II",
      "description":
          "Controla a Melinoë y enfréntate a los dioses del inframundo en este roguelike.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/zvQfWv6r6M2bC6QeA3KJbF.jpg",
      "title": "Clair Obscur: Expedition 33",
      "description":
          "Un RPG artístico con combates por turnos y una narrativa poética sobre el fin del mundo.",
    },
    {
      "image": "https://cdn.mos.cms.futurecdn.net/b6pYpRmpc9f5Hz4bK6yT9K.jpg",
      "title": "Kingdom Come: Deliverance 2",
      "description":
          "Una historia medieval realista con batallas, política y decisiones que cambian tu destino.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(_autoSlideDuration, (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF020024),
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.videogame_asset, color: Color(0xFF8A12E6)),
            const SizedBox(width: 8),
            const Text(
              'GameZone',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          _menuItem('Inicio'),
          _menuItem('Catálogo'),
          _menuItem('Ofertas'),
          _menuItem('Noticias'),
          _menuItem('Contacto'),
          const SizedBox(width: 10),
        ],
      ),

      // 🌀 Carrusel funcional
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                final slide = _slides[index];
                return _carouselImage(
                  imageUrl: slide["image"]!,
                  title: slide["title"]!,
                  description: slide["description"]!,
                );
              },
            ),
          ),
          const SizedBox(height: 15),

          // 🔘 Indicadores del carrusel (puntos)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_slides.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 10,
                width: _currentPage == index ? 25 : 10,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFF8A12E6)
                      : Colors.white38,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Menú superior
  Widget _menuItem(String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Tarjetas del carrusel
  Widget _carouselImage({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    const Color(0xFF020024).withOpacity(0.6),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
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
