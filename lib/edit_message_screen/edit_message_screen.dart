import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/blocs/message_interaction_bloc.dart';
import '../shared/model/message.dart';

class EditMessageScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context, Message message) {
    return Navigator.pushNamed(context, 'editMessage', arguments: message);
  }

  const EditMessageScreen({
    super.key,
    required this.messageToEdit,
  });

  final Message messageToEdit;

  @override
  State<EditMessageScreen> createState() => _EditMessageScreenState();
}

class _EditMessageScreenState extends State<EditMessageScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.messageToEdit.title);
    _descriptionController =
        TextEditingController(text: widget.messageToEdit.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le message'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _saveChanges(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Sauvegarder'),
              onPressed: () => _saveChanges(context),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    final updatedMessage = widget.messageToEdit.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    final bloc = BlocProvider.of<MessageInteractionBloc>(context);
    bloc.add(EditMessage(messageEdited: updatedMessage));

    Navigator.pop(context);
  }
}
