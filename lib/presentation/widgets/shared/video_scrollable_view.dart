import 'package:flutter/material.dart';
import 'package:tecnar_tok/domain/entities/video_post.dart';
import 'package:tecnar_tok/presentation/widgets/shared/fullscreen_player.dart';
import 'package:tecnar_tok/presentation/widgets/shared/video_button.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 600;

        if (isWide) {
          return _WideLayout(videos: videos);
        }

        return _VideoFeed(videos: videos);
      },
    );
  }
}

// ── MODO PC ──
class _WideLayout extends StatefulWidget {
  final List<VideoPost> videos;
  const _WideLayout({required this.videos});

  @override
  State<_WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<_WideLayout> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _goUp() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goDown() {
    if (_currentIndex < widget.videos.length - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Video centrado 9:16
        AspectRatio(
          aspectRatio: 9 / 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.videos.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (context, index) {
                    return FullscreenPlayer(
                      videoUrl: widget.videos[index].videoUrl,
                      caption: widget.videos[index].caption,
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Columna de botones a la derecha
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botones like/vistas con cursor de manito
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: VideoButton(video: widget.videos[_currentIndex]),
            ),

            const SizedBox(height: 24),

            // Flechas de navegación
            _NavButton(icon: Icons.keyboard_arrow_up, onTap: _goUp),
            const SizedBox(height: 8),
            _NavButton(icon: Icons.keyboard_arrow_down, onTap: _goDown),
          ],
        ),
      ],
    );
  }
}

// Botón de navegación arriba/abajo
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // 👈 cursor manito
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}

// ── MODO MÓVIL ──
class _VideoFeed extends StatelessWidget {
  final List<VideoPost> videos;
  const _VideoFeed({required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox.expand(
              child: FullscreenPlayer(
                videoUrl: videos[index].videoUrl,
                caption: videos[index].caption,
              ),
            ),
            Positioned(
              bottom: 40,
              right: 12,
              child: VideoButton(video: videos[index]),
            ),
          ],
        );
      },
    );
  }
}
