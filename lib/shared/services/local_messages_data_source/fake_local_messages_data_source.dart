
import 'package:tp_flutter/shared/model/message.dart';
import 'package:tp_flutter/shared/services/local_messages_data_source/local_messages_data_source.dart';

class FakeLocalMessagesDataSource extends LocalMessagesDataSource {
  List<Message> messagesSaved = [];
  @override
  Future<List<Message>> getAllMessages() async {
    return messagesSaved;
  }
  @override
  Future<String> deleteMessage(int messageId) async {
    return "";
  }
  @override
  Future<String> addMessage(Message message) async {
    return "";
  }
  @override
  Future<String> editMessage(Message messageEdited) async {
    return "";
  }

  @override
  Future<void> saveMessages(List<Message> messages) async {
    messagesSaved = messages;
  }
}
