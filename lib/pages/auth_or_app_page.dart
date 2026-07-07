import 'package:chat_firebase/core/models/chat_user.dart';
import 'package:chat_firebase/core/services/auth/auth_service.dart';
import 'package:chat_firebase/pages/auth_page.dart';
import 'package:chat_firebase/pages/chat_page.dart';
import 'package:chat_firebase/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        },
      ),
    );
  }
}
