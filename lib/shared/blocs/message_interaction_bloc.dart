import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp_flutter/shared/model/message.dart';

import '../../app_exception.dart';
import '../services/messages_repository/messages_repository.dart';

part 'message_interaction_event.dart';

part 'message_interaction_state.dart';

class MessageInteractionBloc
    extends Bloc<MessageInteractionEvent, MessageInteractionState> {
  final MessagesRepository messagesRepository;

  MessageInteractionBloc({required this.messagesRepository})
      : super(MessageInteractionState()) {
    on<AddMessage>(_onAddMessage);
    on<DeleteMessage>(_onDeleteMessage);
    on<EditMessage>(_onEditMessage);
    on<SetInitialMessage>(_onSetInitialMessage);
  }

  void _onAddMessage(
      AddMessage event, Emitter<MessageInteractionState> emit) async {
    emit(state.copyWith(
      status: MessageInteractionStatus.addingMessage,
    ));
    print("ADDING - _addMessage BLOC");


    final message = event.message;
    try {
      final result = messagesRepository.addMessage(message);
      emit(state.copyWith(
        status: MessageInteractionStatus.successAddingMessage,
        message: message,
      ));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(
        status: MessageInteractionStatus.errorAddingMessage,
        exception: appException,
      ));
    }
  }

  void _onDeleteMessage(
      DeleteMessage event, Emitter<MessageInteractionState> emit) {
    emit(state.copyWith(status: MessageInteractionStatus.deletingMessage));

    final messageId = event.messageId;
    try {
      final result = messagesRepository.deleteMessage(messageId);
      emit(state.copyWith(
        status: MessageInteractionStatus.successDeletingMessage,
        messageId: messageId,
      ));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(
        status: MessageInteractionStatus.errorDeletingMessage,
        exception: appException,
      ));
    }
  }

  void _onEditMessage(
      EditMessage event, Emitter<MessageInteractionState> emit) {
    emit(state.copyWith(status: MessageInteractionStatus.editingMessage));

    final messageEdited = event.messageEdited;
    try {
      final result = messagesRepository.editMessage(messageEdited);
      emit(state.copyWith(
        status: MessageInteractionStatus.successEditingMessage,
        message: messageEdited,
      ));
    } catch (error) {
      final appException = AppException.from(error);
      emit(state.copyWith(
        status: MessageInteractionStatus.errorEditingMessage,
        exception: appException,
      ));
    }
  }

  FutureOr<void> _onSetInitialMessage(SetInitialMessage event, Emitter<MessageInteractionState> emit) {
    emit(state.copyWith(
      status: MessageInteractionStatus.initial,
      message: event.initialMessage,
    ));
  }
}
