

import 'package:tp_flutter/app_exception.dart';
import 'package:tp_flutter/shared/model/message.dart';

import 'messages_data_source.dart';

class ApiMessagesDataSource extends MessagesDataSource {
  @override
  Future<List<Message>> getAllMessages() async {
    throw NotImplementedException();
  }
  @override
  Future<String> deleteMessage(messageId) async {
    throw NotImplementedException();
  }
  @override
  Future<String> addMessage(Message message) async {
    throw NotImplementedException();
  }

  @override
  Future<String> editMessage(Message messageEdited) {
    throw UnimplementedError();
  }
}
