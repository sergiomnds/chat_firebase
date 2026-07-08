import 'package:chat_firebase/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> init() async {
    if (await _isAuthorized) {
      await _configureTerminated();
      await _configureForeground();
      await _configureBackground();
    }
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    FirebaseMessaging.onMessage.listen(_messageHandler);
  }

  Future<void> _configureBackground() async {
    FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
  }

  Future<void> _configureTerminated() async {
    RemoteMessage? initialMsg = await FirebaseMessaging.instance
        .getInitialMessage();
    _messageHandler(initialMsg);
  }

  Future<void> _messageHandler(RemoteMessage? msg) async {
    if (msg == null || msg.notification == null) return;
    add(
      ChatNotification(
        title: msg.notification!.title ?? 'Não informado!',
        body: msg.notification!.body ?? 'Não informado!',
      ),
    );
  }
}
