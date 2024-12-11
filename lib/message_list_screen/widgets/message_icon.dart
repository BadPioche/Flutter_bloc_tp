import 'package:flutter/material.dart';

class MessageIcon extends StatelessWidget {
  const MessageIcon({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8),
          Icon(Icons.add),
        ],
      ),
    );
  }
}
