import 'dart:async';
import 'dart:io';
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
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8A12E6),
          secondary: Color.fromARGB(255, 64, 7, 107),
          surface: Color(0xFF1A1A2E),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HoverMenuItem extends StatefulWidget {
  final String text;
  final IconData icon;

  const HoverMenuItem({super.key, required this.text, required this.icon});

  @override
  State<HoverMenuItem> createState() => _HoverMenuItemState();
}

class _HoverMenuItemState extends State<HoverMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isHovered
              ? const Color(0xFF8A12E6).withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered
                ? const Color(0xFF8A12E6).withOpacity(0.7)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF8A12E6).withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: isHovered ? const Color(0xFF8A12E6) : Colors.white70,
              size: isHovered ? 22 : 20,
            ),
            const SizedBox(width: 8),
            Text(
              widget.text,
              style: TextStyle(
                color: isHovered ? const Color(0xFF8A12E6) : Colors.white,
                fontWeight: isHovered ? FontWeight.bold : FontWeight.w600,
                fontSize: isHovered ? 15 : 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
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

  final Duration _autoSlideDuration = const Duration(seconds: 4);

  // 🎮 Lista de juegos con imágenes y descripción
  final List<Map<String, String>> _slides = [
    {
      "image": "assets/image/fornited.webp",
      "title": "Fortnite OG",
      "description": "Revive los momentos clásicos en la isla original.",
    },
    {
      "image": "assets/image/gta-online-the-chop-shop-4m.jpg",
      "title": "GTA V",
      "description": "Explora Los Santos con total libertad.",
    },
    {
      "image": "assets/image/resident-evil-4k-2023-3v.jpg",
      "title": "Resident Evil 4 Remake",
      "description": "Terror clásico reinventado por Capcom.",
    },
    {
      "image": "assets/image/2025-red-dead-redemption-2-game-p8.jpg",
      "title": "Red Dead Redemption 2",
      "description":
          "Vive el salvaje oeste con Arthur Morgan y la banda de Van der Linde.",
    },
    {
      "image": "assets/image/enigmatic-cyberpunk-2077-5s.jpg",
      "title": "Cyberpunk 2077",
      "description":
          "Explora Night City y define tu destino como V, un mercenario cibernético.",
    },
    {
      "image": "assets/image/hollow-knight-silksong-ax.jpg",
      "title": "Hollow Knight",
      "description":
          "Una aventura oscura y hermosa bajo tierra llena de misterio y acción.",
    },
    {
      "image": "assets/image/buckshot.png",
      "title": "Buckshot Roulette",
      "description":
          "Juega a la ruleta rusa con un giro sangriento y psicológico.",
    },
    {
      "image": "assets/image/theforest.jpg",
      "title": "The Forest",
      "description":
          "Sobrevive en una isla llena de secretos, caníbales y terror psicológico.",
    },
    {
      "image": "assets/image/god-of-war-ragnarok-46.jpg",
      "title": "God of War Ragnarök",
      "description":
          "Acompaña a Kratos y Atreus en su épico viaje por los reinos nórdicos.",
    },
    {
      "image": "assets/image/monster-hunter-wilds-deluxe-edition-2025-bq.jpg",
      "title": "Monster Hunter Wilds",
      "description":
          "Caza bestias colosales en un vasto mundo abierto con un ecosistema dinámico.",
    },
    {
      "image":
          "assets/image/final-fantasy-vii-rebirth-aerith-gainsborough-and-tifa-lockhart-93.jpg",
      "title": "Final Fantasy VII Rebirth",
      "description":
          "Continúa la historia de Cloud y sus amigos en una reimaginación espectacular del clásico.",
    },
    {
      "image": "assets/image/senuas-saga-hellblade-2-4k-wy.jpg",
      "title": "Senua’s Saga: Hellblade II",
      "description":
          "Una experiencia cinematográfica con gráficos de nueva generación y narrativa intensa.",
    },
    {
      "image": "assets/image/silent-hill-2-vy.jpg",
      "title": "Silent Hill 2",
      "description":
          "Un clásico del survival horror psicológico: historia oscura, atmósfera opresiva y uno de los mejores argumentos del género.",
    },
    {
      "image": "assets/image/valorant-game-characters-girls-jq.jpg",
      "title": "Valorant",
      "description":
          "Un shooter táctico 5v5 de Riot Games donde la precisión, las habilidades y el trabajo en equipo son la clave para la victoria.",
    },
    {
      "image": "assets/image/call-of-duty-warzone-mobile-5k-game-yd.jpg",
      "title": "Call of Duty: Warzone",
      "description":
          "Una batalla campal intensa en un mapa enorme donde solo los más estratégicos sobreviven. Acción, disparos y adrenalina pura.",
    },
  ];

  final Map<String, bool> _imageCache = {};

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _preCheckImages();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _preCheckImages() async {
    for (var slide in _slides) {
      final imageUrl = slide["image"]!;
      if (!_imageCache.containsKey(imageUrl)) {
        try {
          final response = await _checkImageAvailability(imageUrl);
          _imageCache[imageUrl] = response;
        } catch (e) {
          _imageCache[imageUrl] = false;
        }
      }
    }
    setState(() {});
  }

  Future<bool> _checkImageAvailability(String url) async {
    final client = HttpClient();
    try {
      client.connectionTimeout = const Duration(seconds: 10);
      final request = await client.getUrl(Uri.parse(url));
      request.headers.add(
        'User-Agent',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      );
      final response = await request.close();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    } finally {
      client.close();
    }
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(_autoSlideDuration, (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildElegantMenuItem(String text, IconData icon) {
    return HoverMenuItem(text: text, icon: icon);
  }

  Widget _carouselImage({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildImageWithFallback(imageUrl),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                    const Color(0xFF020024).withOpacity(0.6),
                  ],
                  stops: const [0.0, 0.3, 1.0],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8A12E6),
                          Color.fromARGB(255, 64, 7, 107),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8A12E6).withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.4,
                      ),
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

  Widget _buildImageWithFallback(String imageUrl) {
    // Si el path empieza con 'assets/', es local
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      // En caso de que en el futuro uses imágenes de internet
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingIndicator(loadingProgress);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    }
  }

  Widget _buildLoadingIndicator(ImageChunkEvent loadingProgress) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF020024)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 4,
                backgroundColor: const Color(0xFF1A1A2E),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF8A12E6),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cargando aventura...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF020024)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset_rounded,
              color: const Color(0xFF8A12E6).withOpacity(0.7),
              size: 60,
            ),
            const SizedBox(height: 15),
            const Text(
              'Preparando experiencia...',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF020024)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image_rounded, color: Colors.grey[600], size: 60),
            const SizedBox(height: 15),
            Text(
              'Imagen no disponible',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Explorando nuevos mundos...',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            // Corrección: Image.asset debe estar dentro de un children
            Image.asset(
              'assets/image/logo/logo.png',
              height: MediaQuery.of(context).size.height * 0.06,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          _buildElegantMenuItem('Inicio', Icons.home_filled),
          _buildElegantMenuItem('Catálogo', Icons.grid_view_rounded),
          _buildElegantMenuItem('Ofertas', Icons.local_offer_rounded),
          _buildElegantMenuItem('Servicios', Icons.home_work_outlined),
          _buildElegantMenuItem('Noticias', Icons.newspaper_rounded),
          _buildElegantMenuItem('Contacto', Icons.contact_support_rounded),
          const SizedBox(width: 20),
        ],
      ),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: _currentPage == index ? 12 : 8,
                  width: _currentPage == index ? 30 : 8,
                  decoration: BoxDecoration(
                    gradient: _currentPage == index
                        ? const LinearGradient(
                            colors: [Color(0xFF8A12E6), Color(0xFF00D4FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: _currentPage == index ? null : Colors.white38,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: _currentPage == index
                        ? [
                            BoxShadow(
                              color: const Color(0xFF8A12E6).withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
