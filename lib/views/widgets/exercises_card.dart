import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class ExercisesCard extends StatefulWidget {
  const ExercisesCard({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  ExercisesCardState createState() => ExercisesCardState();
}

class ExercisesCardState extends State<ExercisesCard> {
  bool _isPressed = false;

  void _handleTap(bool pressed) => setState(() => _isPressed = pressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTapDown: (_) => _handleTap(true),
        onTapUp: (_) {
          _handleTap(false);
          widget.onTap?.call();
        },
        onTapCancel: () => _handleTap(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLeftSquare(),
              const SizedBox(width: 16),
              _buildTextContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSquare() {
    return Container(
      width: 90, // Largeur du carré
      height: 70, // Hauteur du carré
      color: Colors.red, // Couleur du carré
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: fitWeightBold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                widget.subtitle ?? '',
                style: const TextStyle(
                  color: fitBlueMiddle,
                  fontSize: 16,
                  fontWeight: fitWeightMedium,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
