import 'package:chat_firebase/components/messages.dart';
import 'package:chat_firebase/components/new_message.dart';
import 'package:chat_firebase/core/services/auth/auth_service.dart';
import 'package:chat_firebase/core/services/notification/chat_notification_service.dart';
import 'package:chat_firebase/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'Cod3r Chat',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return NotificationPage();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ChatNotificationService>(context, listen: false).add(
            ChatNotification(
              title: 'Notificação',
              body: Random().nextDouble().toString(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}
