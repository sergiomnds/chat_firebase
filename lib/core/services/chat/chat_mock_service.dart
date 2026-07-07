import 'dart:async';
import 'dart:math';

import 'package:chat_firebase/core/models/chat_message.dart';
import 'package:chat_firebase/core/models/chat_user.dart';
import 'package:chat_firebase/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    /*ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Teste',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Boa tarde',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Teste 2',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Boa noite',
      createdAt: DateTime.now(),
      userId: '789',
      userName: 'Teste 3',
      userImageUrl: 'assets/images/avatar.png',
    ),*/
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);
    _controller!.add(_msgs.reversed.toList());

    return newMessage;
  }
}
