part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {
  const MessageEvent();
}

class GetAllMessages extends MessageEvent{
  final String filter;
  const GetAllMessages(this.filter);
}