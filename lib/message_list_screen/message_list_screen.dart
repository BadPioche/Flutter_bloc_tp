import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tp_flutter/message_list_screen/message_bloc/message_bloc.dart';
import 'package:tp_flutter/message_list_screen/message_detail_screen/message_detail_screen.dart';
import 'package:tp_flutter/message_list_screen/widgets/message_icon.dart';
import 'package:tp_flutter/message_list_screen/widgets/message_list_item.dart';

import '../add_message_screen/add_message_screen.dart';
import '../app_exception.dart';
import '../shared/blocs/message_interaction_bloc.dart';
import '../shared/model/message.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  void initState() {
    super.initState();
    _getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MessageBloc, MessageState>(
          listener: (context, state) {
            if (state.status == MessageStatus.error) {
              _showSnackBar(context, state.exception);
            }
          },
        ),
        BlocListener<MessageInteractionBloc, MessageInteractionState>(
          listener: (context, state) {
            if (state.status == MessageInteractionStatus.errorAddingMessage) {
              _showSnackBar(context, state.exception);
            }
            if (state.status == MessageInteractionStatus.successAddingMessage ||
                state.status ==
                    MessageInteractionStatus.successDeletingMessage ||
                state.status ==
                    MessageInteractionStatus.successEditingMessage) {
              _showSnackBar(context, null, status: "success");
              _getAllMessages();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chatting with myself'),
          actions: [
            MessageIcon(
              onTap: () => _openAddMessageScreen(context),
            )
          ],
        ),
        body: BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
          return switch (state.status) {
            MessageStatus.initial ||
            MessageStatus.loading =>
              _buildLoading(context),
            MessageStatus.error => _buildError(context, state.exception),
            MessageStatus.success => _buildSuccess(context, state.messages),
          };
        }),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, AppException? exception) {
    return Center(
      child: Text('Oups, une erreur est survenur: $exception'),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Message> messages) {
    return RefreshIndicator(
      onRefresh: () async => _getAllMessages(),
      child: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final message = messages[index];
          return MessageListItem(
            message: message,
            onTap: () => _openMessageDetailScreen(context, message),
          );
        },
      ),
    );
  }

  _openMessageDetailScreen(BuildContext context, Message message) {
    MessageDetailScreen.navigateTo(context, message);
  }

  void _getAllMessages() {
    final messagesBloc = BlocProvider.of<MessageBloc>(context);
    messagesBloc.add(const GetAllMessages(''));
  }
}

void _openAddMessageScreen(context) {
  AddMessageScreen.navigateTo(context);
}

void _showSnackBar(BuildContext context, AppException? exception,
    {String status = "error"}) {
  final snackBar = SnackBar(
    content: Text(
      status == "success"
          ? "Opération réussie !"
          : "Une erreur s'est produite : ${exception}",
    ),
    backgroundColor: status == "success" ? Colors.green : Colors.red,
    duration: const Duration(seconds: 1),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
