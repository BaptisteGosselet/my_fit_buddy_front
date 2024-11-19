import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';

class SessionCard extends StatefulWidget {
  const SessionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  SessionCardState createState() => SessionCardState();
}

class SessionCardState extends State<SessionCard> {
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
              _buildTextContent(),
              const SizedBox(width: 16),
              const Icon(Icons.chevron_right, color: fitBlueDark, size: 40),
            ],
          ),
        ),
      ),
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
              if (widget.icon != null)
                Icon(widget.icon, color: fitBlueMiddle, size: 20),
              if (widget.icon != null) const SizedBox(width: 4),
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
