import 'package:flutter/material.dart';

Future<void> loadingScreen({required BuildContext context}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text('Loading'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    },
    barrierDismissible: false,
  );
}
