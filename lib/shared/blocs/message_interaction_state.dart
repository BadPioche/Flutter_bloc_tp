part of 'message_interaction_bloc.dart';

enum MessageInteractionStatus {
  initial,
  addingMessage,
  successAddingMessage,
  errorAddingMessage,
  deletingMessage,
  successDeletingMessage,
  errorDeletingMessage,
  editingMessage,
  successEditingMessage,
  errorEditingMessage,
}

class MessageInteractionState {
  final MessageInteractionStatus status;
  Message? message;
  int? messageId;
  final AppException? exception;

  MessageInteractionState({
    this.status = MessageInteractionStatus.initial,
    this.message,
    this.messageId,
    this.exception,
  });

  MessageInteractionState copyWith({
    MessageInteractionStatus? status,
    Message? message,
    int? messageId,
    AppException? exception,
  }) {
    return MessageInteractionState(
      status: status ?? this.status,
      message: message ?? this.message,
      messageId: messageId ?? this.messageId,
      exception: exception,
    );
  }
}
