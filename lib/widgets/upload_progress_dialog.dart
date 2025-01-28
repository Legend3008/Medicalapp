import 'package:flutter/material.dart';

class UploadProgressDialog extends StatelessWidget {
  const UploadProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Uploading file...'),
        ],
      ),
    );
  }
} 