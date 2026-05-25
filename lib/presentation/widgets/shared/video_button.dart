import 'package:flutter/material.dart';
import 'package:tecnar_tok/domain/entities/video_post.dart';

class VideoButton extends StatefulWidget {
  final VideoPost video;
  const VideoButton({super.key, required this.video});

  @override
  State<VideoButton> createState() => _VideoButtonState();
}

class _VideoButtonState extends State<VideoButton> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(
          value: widget.video.likes,
          iconData: Icons.favorite,
          iconColor: Colors.red,
        ),
        const SizedBox(height: 10),
        _CustomIconButton(
          value: widget.video.views,
          iconData: Icons.remove_red_eye_outlined,
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 10),

        // Botón pausa/play
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Column(
              children: [
                Icon(
                  _isPlaying
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color color;

  _CustomIconButton({
    required this.value,
    required this.iconData,
    Color? iconColor,
  }) : color = iconColor ?? Colors.white;

  String _formatNumber(int number) {
    if (number >= 1000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    if (number >= 1000) return '${(number / 1000).toStringAsFixed(1)}K';
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(iconData, color: color, size: 30),
          ),
          if (value > 0)
            Text(
              _formatNumber(value),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
