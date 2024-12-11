
import 'package:tp_flutter/app_exception.dart';
import 'package:tp_flutter/shared/services/local_messages_data_source/local_messages_data_source.dart';

import '../../model/message.dart';
import '../remote_messages_data_source/messages_data_source.dart';

class MessagesRepository {
  final MessagesDataSource remoteDataSource;
  final LocalMessagesDataSource localMessagesDataSource;

  MessagesRepository({
    required this.remoteDataSource,
    required this.localMessagesDataSource,
  });

  Future<List<Message>> getAllMessages() async {
    try {
      final messages = await remoteDataSource.getAllMessages();
      localMessagesDataSource.saveMessages(messages);
      return messages;
    } catch (error) {
      return localMessagesDataSource.getAllMessages();
    }
  }
  Future<String> deleteMessage(messageId) async {
    try {
      final result = await remoteDataSource.deleteMessage(messageId);
      localMessagesDataSource.deleteMessage(messageId);
      return result;
    } catch (error) {
      throw ApiException(error: error);
    }
  }

  Future<String> addMessage(Message message) async {
    try {
      final result = await remoteDataSource.addMessage(message);
      localMessagesDataSource.addMessage(message);
      return result;
    } catch (error) {
      throw ApiException(error: error);
    }
  }
  Future<String> editMessage(Message message) async {
    try {
      final result = await remoteDataSource.editMessage(message);
      localMessagesDataSource.editMessage(message);
      return result;
    } catch (error) {
      throw ApiException(error: error);
    }
  }
}
