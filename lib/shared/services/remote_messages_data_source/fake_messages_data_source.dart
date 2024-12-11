import 'package:tp_flutter/shared/model/message.dart';

import 'messages_data_source.dart';

class FakeMessagesDataSource extends MessagesDataSource {
  List<Message> _fakeMessages = List.generate(10, (index) {
    return Message(
      id: index,
      title: 'Message $index',
      description: 'Description du message $index',
    );
  });
  @override
  Future<List<Message>> getAllMessages() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakeMessages;
  }
  @override
  Future<String> deleteMessage(messageId) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakeMessages = _fakeMessages.where((message) => message.id != messageId).toList();
    return "success";
  }

  @override
  Future<String> addMessage(Message message) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakeMessages.add(message);
    return "success";
  }

  @override
  Future<String> editMessage(Message messageEdited) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakeMessages = _fakeMessages.map((message) {
      return message.id == messageEdited.id ? messageEdited : message;
    }).toList();
    return "success";
  }
}
