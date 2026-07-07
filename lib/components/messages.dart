import 'package:chat_firebase/components/message_bubble.dart';
import 'package:chat_firebase/core/services/auth/auth_service.dart';
import 'package:chat_firebase/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Sem Dados. Vamos Conversar?'));
        } else {
          final msgs = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToCurrentUser: msgs[i].userId == currentUser?.id,
            ),
          );
        }
      },
    );
  }
}
