import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat_messages.dart';
import '../widgets/modern_background.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');
   
  }

  @override
  void initState() {
    super.initState();

    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.black.withValues(alpha: 0.72),
              surfaceTintColor: Colors.transparent,
              titleSpacing: 4,
              title: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE53935).withValues(alpha: 0.98),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE53935).withValues(alpha: 0.65),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Echo Realm',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          'Live · community chat',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.85),
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton.filledTonal(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(Icons.logout_rounded, size: 22),
                    style: IconButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const ModernMeshBackground(
        brightness: MeshBrightness.light,
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
