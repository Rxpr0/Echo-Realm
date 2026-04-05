import 'package:flutter/material.dart';

class EchoRealmLogo extends StatelessWidget {
  const EchoRealmLogo({
    super.key,
    this.compact = false,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 40.0 : 52.0;
    final titleSize = compact ? 22.0 : 28.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(compact ? 14 : 18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF5252),
                Color(0xFFDC2626),
                Color(0xFF7F1D1D),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFDC2626).withValues(alpha: 0.55),
                blurRadius: compact ? 16 : 28,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.graphic_eq_rounded,
            size: iconSize,
            color: Colors.white,
          ),
        ),
        SizedBox(height: compact ? 12 : 18),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFFFCDD2),
            ],
          ).createShader(bounds),
          child: Text(
            'Echo Realm',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
        ),
        if (!compact) ...[
          const SizedBox(height: 6),
          Text(
            'Chat that feels alive',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}
