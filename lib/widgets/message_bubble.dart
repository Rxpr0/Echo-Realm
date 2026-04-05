import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
    this.timeLabel,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null,
        timeLabel = null;

  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;
  final String? timeLabel;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.sizeOf(context).width;
    final maxBubbleW = (screenW * 0.78).clamp(200.0, 320.0);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (!isMe && isFirstInSequence)
          Positioned(
            top: 10,
            left: 0,
            child: _Avatar(
              imageUrl: userImage,
              username: username,
              theme: theme,
            ),
          ),
        if (isMe && isFirstInSequence)
          Positioned(
            top: 10,
            right: 0,
            child: _Avatar(
              imageUrl: userImage,
              username: username,
              theme: theme,
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            left: isMe
                ? (isFirstInSequence ? 40 : 20)
                : (isFirstInSequence ? 52 : 52),
            right: isMe
                ? 52
                : (isFirstInSequence ? 40 : 40),
          ),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (isFirstInSequence) const SizedBox(height: 14),
                    if (username != null && username!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                          left: isMe ? 0 : 6,
                          right: isMe ? 6 : 0,
                          bottom: 4,
                        ),
                        child: Text(
                          username!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.2,
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.9,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      constraints: BoxConstraints(maxWidth: maxBubbleW),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        gradient: isMe
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFE53935),
                                  Color(0xFF991B1B),
                                ],
                              )
                            : null,
                        color: isMe
                            ? null
                            : const Color(0xFF1A1A1A).withValues(alpha: 0.96),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            !isMe && isFirstInSequence ? 6 : _radius,
                          ),
                          topRight: Radius.circular(
                            isMe && isFirstInSequence ? 6 : _radius,
                          ),
                          bottomLeft: const Radius.circular(_radius),
                          bottomRight: const Radius.circular(_radius),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isMe
                                ? const Color(0xFFDC2626)
                                    .withValues(alpha: 0.35)
                                : Colors.black.withValues(alpha: 0.35),
                            blurRadius: isMe ? 18 : 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        border: isMe
                            ? null
                            : Border.all(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.2),
                              ),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          height: 1.35,
                          fontSize: 15,
                          color: isMe
                              ? Colors.white.withValues(alpha: 0.98)
                              : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                      ),
                    ),
                    if (timeLabel != null &&
                        timeLabel!.isNotEmpty &&
                        isFirstInSequence)
                      Padding(
                        padding: EdgeInsets.only(
                          top: 2,
                          left: isMe ? 0 : 8,
                          right: isMe ? 8 : 0,
                        ),
                        child: Text(
                          timeLabel!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.45),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.imageUrl,
    required this.username,
    required this.theme,
  });

  final String? imageUrl;
  final String? username;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final letter = (username != null && username!.trim().isNotEmpty)
        ? username!.trim()[0].toUpperCase()
        : '?';

    Widget child;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = Image.network(
        imageUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _initials(letter),
        loadingBuilder: (ctx, w, ev) {
          if (ev == null) {
            return w;
          }
          return _initials(letter);
        },
      );
    } else {
      child = _initials(letter);
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.35),
            theme.colorScheme.tertiary.withValues(alpha: 0.45),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: ColoredBox(
          color: const Color(0xFF242424),
          child: child,
        ),
      ),
    );
  }

  Widget _initials(String letter) {
    return Center(
      child: Text(
        letter,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
