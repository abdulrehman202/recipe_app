import 'package:flutter/material.dart';

_dialogBox(BuildContext context, AlertDialog dialog) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

passwordResetDialogBox(BuildContext context, String msg,) {
  return _dialogBox(
      context,
      AlertDialog(
        content: Text(
          msg,
        ),
        actions: [
          FilledButton(
              onPressed: (){
                
                Navigator.pop(context);
                
                },
              child: const Center(child: Text('Reset Password')))
        ],
      ));
}
