import 'package:flutter/material.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/loading_dialog.dart';

Future<void> failureDialog({
  required final BuildContext context,
  required String message,
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
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                CustomButton(
                  text: "ລອງໃໝ່ອີກຄັ້ງ",
                  onPressed: () {
                    Navigator.pop(context);
                    LoadingDialog.hideLoadingDialog(context);
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
