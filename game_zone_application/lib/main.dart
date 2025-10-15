import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(GameZoneApp());
}

class GameZoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF020024),
        primaryColor: const Color(0xFF8A12E6),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
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

  // 🖼️ Aquí puedes añadir o quitar tus propias imágenes y textos
  final List<Map<String, String>> _slides = [
    {
      "image":
          "https://i.pinimg.com/736x/2b/02/f0/2b02f09dda89cfbef21b7bc3eea90fc4.jpg",
      "title": "Fortnite OG",
      "description": "Revive los momentos clásicos en la isla original."
    },
    {
      "image":
          "https://i.pinimg.com/1200x/9a/2c/1c/9a2c1c428752523b0a8c6a5cb65a386e.jpg",
      "title": "GTA V",
      "description": "Explora Los Santos con total libertad."
    },
    {
      "image":
          "https://i.pinimg.com/1200x/0b/ea/3b/0bea3b30b35c95412b8f9940b210bc85.jpg",
      "title": "Resident Evil 4 Remake",
      "description": "Terror clásico reinventado por Capcom."
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
                    const Color(0xFF020024).withOpacity(0.6)
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
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
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