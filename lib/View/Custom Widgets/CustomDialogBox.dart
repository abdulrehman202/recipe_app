import 'package:flutter/material.dart';
dialogBox(BuildContext context, AlertDialog dialog) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

passwordResetDialogBox(
  BuildContext context,
  String msg,
) {
  return dialogBox(
      context,
      AlertDialog(
        content: Text(
          msg,
        ),
        actions: [
          FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(child: Text('Reset Password')))
        ],
      ));
}
