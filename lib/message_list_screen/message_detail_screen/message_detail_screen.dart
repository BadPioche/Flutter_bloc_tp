import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/edit_message_screen/edit_message_screen.dart';
import 'package:tp_flutter/shared/blocs/message_interaction_bloc.dart';
import 'package:tp_flutter/shared/model/message.dart';
import 'package:tp_flutter/shared/services/messages_repository/messages_repository.dart';

import '../../app_exception.dart';
import '../message_bloc/message_bloc.dart';

class MessageDetailScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Message message) {
    return Navigator.pushNamed(context, 'messageDetail', arguments: message);
  }

  const MessageDetailScreen({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  void initState() {
    super.initState();
    //initialize the bloc with the initial message, can only be done once we know
    //which message has been selected
    BlocProvider.of<MessageInteractionBloc>(context)
        .add(SetInitialMessage(initialMessage: widget.message));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInteractionBloc, MessageInteractionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.message?.title ?? ''),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editMessage(context, state.message!),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDelete(context, state.message!),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.message?.title ?? 'Sans titre'),
                  const SizedBox(height: 16),
                  Text(state.message?.description ?? 'Pas de description'),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: const Text('Modifier'),
                        onPressed: () => _editMessage(context, state.message!),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('Supprimer'),
                        onPressed: () => _confirmDelete(context, state.message!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }

  void _confirmDelete(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ce message ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(context, message);
                Navigator.pop(context); // Ferme la boîte de dialogue
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  void _editMessage(BuildContext context, Message message) {
    EditMessageScreen.navigateTo(context, message);
  }

  void _deleteMessage(BuildContext context, Message message) {
    final bloc = BlocProvider.of<MessageInteractionBloc>(context);
    bloc.add(DeleteMessage(messageId: message.id));

    Navigator.pop(context);
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
}
