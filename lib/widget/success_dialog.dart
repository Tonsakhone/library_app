import 'package:flutter/material.dart';

import 'package:libary_management/widget/custom_button.dart';

Future<void> successDialog({
  required final BuildContext context,
  required String message,
  required final Function() onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                CustomButton(text: "Ok", onPressed: onPressed),
              ],
            ),
          ),
        ),
      );
    },
  );
}
