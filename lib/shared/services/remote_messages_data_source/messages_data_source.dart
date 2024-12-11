import '../../model/message.dart';

abstract class MessagesDataSource {
  Future<List<Message>> getAllMessages();
  Future<String> deleteMessage(int messageId);
  Future<String> addMessage(Message message);
  Future<String> editMessage(Message messageEdited);
}
