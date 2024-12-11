import 'package:flutter/material.dart';

import '../../shared/model/message.dart';


class MessageListItem extends StatelessWidget {
  const MessageListItem({
    super.key,
    required this.message,
    this.onTap,
  });

  final Message message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.title),
      subtitle: Text(message.description),
      onTap: onTap,
    );
  }
}
