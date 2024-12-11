

import '../../model/message.dart';
import '../remote_messages_data_source/messages_data_source.dart';

abstract class LocalMessagesDataSource extends MessagesDataSource {
  @override
  Future<List<Message>> getAllMessages();
  @override
  Future<String> deleteMessage(int messageId);
  @override
  Future<String> addMessage(Message message);
  @override
  Future<String> editMessage(Message messageEdited);

  Future<void> saveMessages(List<Message> messages);
}
