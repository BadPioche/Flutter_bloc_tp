import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import '../shared/blocs/message_interaction_bloc.dart';
import '../shared/model/message.dart';

class AddMessageScreen extends StatefulWidget {
  static Future<void> navigateTo(BuildContext context) {
    return Navigator.pushNamed(context, '/addMessageScreen');
  }
  const AddMessageScreen({super.key});

  @override
  State<AddMessageScreen> createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends State<AddMessageScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
        title: const Text('Ajouter un message'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _addMessage(context),
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
              icon: const Icon(Icons.add),
              label: const Text('Ajouter le message'),
              onPressed: () => _addMessage(context),
            ),
          ],
        ),
      ),
    );
  }

  void _addMessage(BuildContext context) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showError(context, 'Veuillez remplir tous les champs.');
      return;
    }

    final newMessage = Message(
      id: Random().nextInt(100000000),
      title: _titleController.text,
      description: _descriptionController.text,
    );

    final bloc = BlocProvider.of<MessageInteractionBloc>(context);
    bloc.add(AddMessage(message: newMessage));

    Navigator.pop(context);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}