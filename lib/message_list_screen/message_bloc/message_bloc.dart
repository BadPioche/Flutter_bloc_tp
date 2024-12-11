import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tp_flutter/shared/blocs/message_interaction_bloc.dart';
import 'package:tp_flutter/shared/services/messages_repository/messages_repository.dart';

import '../../app_exception.dart';
import '../../shared/model/message.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessagesRepository messagesRepository;

  MessageBloc({required this.messagesRepository})
      : super(const MessageState()) {
    on<GetAllMessages>((event, emit) async {
      final filter = event.filter;
      emit(state.copyWith(status: MessageStatus.loading));

      try {
        final messages = await messagesRepository.getAllMessages();
        emit(state.copyWith(
          messages: messages,
          status: MessageStatus.success,
        ));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: MessageStatus.error,
          exception: appException,
        ));
      }
    });
  }
}
