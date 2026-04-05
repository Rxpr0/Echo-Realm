import 'package:flutter/material.dart';

import '../widgets/echo_realm_logo.dart';
import '../widgets/modern_background.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModernMeshBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EchoRealmLogo(compact: true),
              const SizedBox(height: 36),
              SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: const Color(0xFFE53935),
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
