import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/view_models/chat/chat_provider.dart';

import '../../models/message_model.dart';

class ChatViewModel with ChangeNotifier{
  final ChatProvider _chatProvider;
  ChatViewModel(this._chatProvider);

  List<Message>? _messages;
 List<Message> get messages => _messages ?? [];


  Future<void> getMessages(String chatId) async {
    final snapshot = await _chatProvider.getNewMessage(chatId).single;
    _messages = snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    notifyListeners();
  }


  
Stream getListOfMessages(String chatId) async* {
  await for (QuerySnapshot<Map<String, dynamic>> snapshot in _chatProvider.getNewMessage(chatId)) {
    List<Message> messages = snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    yield messages;
    notifyListeners();
  }
}
//   Stream<List<Message>> getNonReadMessages(String chatId) async* {
//   QuerySnapshot<Map<String, dynamic>> snapshot = await _chatProvider.getNewMessage(chatId).single;
//   List<Message> messageList = snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();

//   // Filter messages that are not read
//   List<Message> nonReadMessages = messageList.where((message) => !message.read).toList();

//   // Emit the non-read messages as a stream
//   yield nonReadMessages;
// }

//////////////////////////////////////////////////////////////////////
  Stream<QuerySnapshot<Object?>> getNewChat({required currentUserId})async* {
  final snapshot= _chatProvider.getNewChat(currentUserId);
 // _chats = snapshot.map((doc) => Chat.fromJson(doc.data()));
  }

Stream<QuerySnapshot<Map<String, dynamic>>> getNewMessage({required chatId}) async*{
   yield* _chatProvider.getNewMessage(chatId);
  }

  sendMessage(
    value, {
    required String currentUserId,
    required String friendName,
    required String friendId,
    required String chatId,
    required String message,
  }) {
    if (value == null) {
      _chatProvider.createNewChat(
          currentUserId: currentUserId,
          friendName: friendName,
          friendId: friendId,
          chatId: chatId);
      _chatProvider.sendNewMessage(
          chatId: chatId, message: message, currentUserId: currentUserId);
    } else {
      _chatProvider.sendNewMessage(
          chatId: chatId, message: message, currentUserId: currentUserId);
    }
  }

}