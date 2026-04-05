import 'dart:ui';

import 'package:flutter/material.dart';

/// Black-base mesh with red accent orbs.
class ModernMeshBackground extends StatelessWidget {
  const ModernMeshBackground({
    super.key,
    required this.child,
    this.brightness = MeshBrightness.dark,
  });

  final Widget child;
  final MeshBrightness brightness;

  @override
  Widget build(BuildContext context) {
    final isChat = brightness == MeshBrightness.light;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isChat
                  ? const [
                      Color(0xFF070707),
                      Color(0xFF0F0A0A),
                      Color(0xFF120808),
                    ]
                  : const [
                      Color(0xFF000000),
                      Color(0xFF0D0505),
                      Color(0xFF140606),
                    ],
            ),
          ),
        ),
        Positioned(
          top: -60,
          right: -40,
          child: _Blob(
            color: const Color(0xFFDC2626).withValues(alpha: 0.32),
            size: 200,
          ),
        ),
        Positioned(
          bottom: 80,
          left: -80,
          child: _Blob(
            color: const Color(0xFF7F1D1D).withValues(alpha: 0.5),
            size: 260,
          ),
        ),
        Positioned(
          top: 180,
          left: 20,
          child: _Blob(
            color: const Color(0xFFB91C1C).withValues(alpha: 0.22),
            size: 140,
          ),
        ),
        if (isChat)
          Positioned(
            bottom: 120,
            left: -60,
            child: _Blob(
              color: const Color(0xFF450A0A).withValues(alpha: 0.35),
              size: 200,
            ),
          ),
        child,
      ],
    );
  }
}

enum MeshBrightness { dark, light }

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
