part of 'message_interaction_bloc.dart';

@immutable
sealed class MessageInteractionEvent {
  const MessageInteractionEvent();
}

class AddMessage extends MessageInteractionEvent {
  final Message message;

  const AddMessage({required this.message});
}

class DeleteMessage extends MessageInteractionEvent {
  final int messageId;

  const DeleteMessage({required this.messageId});
}

class EditMessage extends MessageInteractionEvent {
  final Message messageEdited;

  const EditMessage({required this.messageEdited});

}

class SetInitialMessage extends MessageInteractionEvent {
  final Message initialMessage;

  const SetInitialMessage({required this.initialMessage});
}
