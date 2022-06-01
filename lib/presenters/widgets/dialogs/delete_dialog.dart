import 'package:flutter/material.dart';

Future<void> showDeleteDialog(
  BuildContext context,
  {required String title, required String message, required VoidCallback onDelete}
) async {
  return await showDialog(
    context: context,
    builder: (context) => DeleteDialog(title: title, message: message, onDelete: onDelete,),
  );
}

class DeleteDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onDelete;

  const DeleteDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onDelete,
          style: ElevatedButton.styleFrom( primary: Theme.of(context).errorColor),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
