import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_realm/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  static String? _timeLabel(dynamic raw) {
    if (raw is Timestamp) {
      final d = raw.toDate();
      final h = d.hour.toString().padLeft(2, '0');
      final m = d.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    final theme = Theme.of(context);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_off_rounded,
                    size: 48,
                    color: theme.colorScheme.error.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Could not load messages',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check your connection and try again.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Syncing conversation…',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.15),
                          theme.colorScheme.tertiary.withValues(alpha: 0.2),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary
                              .withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.forum_rounded,
                      size: 40,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No messages yet',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Say hello and start the conversation.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            final text = chatMessage['text']?.toString() ?? '';
            final time = _timeLabel(chatMessage['createdAt']);

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: text,
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
            return MessageBubble.first(
              userImage: chatMessage['userImage'] as String?,
              username: chatMessage['username'] as String?,
              message: text,
              isMe: authenticatedUser.uid == currentMessageUserId,
              timeLabel: time,
            );
          },
        );
      },
    );
  }
}
