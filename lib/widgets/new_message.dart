import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final profile = userDoc.data();

    final usernameFromProfile = profile?['username'];
    final username = usernameFromProfile is String && usernameFromProfile.isNotEmpty
        ? usernameFromProfile
        : (user.displayName?.trim().isNotEmpty == true
            ? user.displayName!.trim()
            : user.email != null && user.email!.contains('@')
                ? user.email!.split('@').first
                : 'User');

    final imageUrl = profile?['image_url'];
    final userImage =
        imageUrl is String && imageUrl.isNotEmpty ? imageUrl : null;

    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': username,
      if (userImage != null) 'userImage': userImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 10 + bottomInset),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF141414).withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDC2626).withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.45),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a message…',
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.38),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onSubmitted: (_) => _submitMessage(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFF5252),
                    Color(0xFFB91C1C),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFDC2626).withValues(alpha: 0.55),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _submitMessage,
                  child: const SizedBox(
                    width: 52,
                    height: 52,
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
