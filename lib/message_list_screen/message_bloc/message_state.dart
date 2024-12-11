part of 'message_bloc.dart';

enum MessageStatus {
  initial,
  loading,
  success,
  error,
}

class MessageState {
  final MessageStatus status;
  final List<Message> messages;
  final AppException? exception;

  const MessageState({
    this.status = MessageStatus.initial,
    this.messages = const [],
    this.exception,
  });

  MessageState copyWith({
    MessageStatus? status,
    List<Message>? messages,
    AppException? exception,
  }) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      exception: exception ?? this.exception,
    );
  }

  int getNumberOfMessages() {
    return messages.length;
  }
}