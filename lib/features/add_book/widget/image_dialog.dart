import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> imageDialog({
  required BuildContext context,
  required Function(String?) onFileSelected,
  required bool isImageOnly,
}) async {
  final ImagePicker picker = ImagePicker();

  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    context: context,
    builder: (BuildContext context) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  onFileSelected(photo.path);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text("Take a Photo"),
              ),
            ),
            InkWell(
              onTap: () async {
                final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
                if (photo != null) {
                  onFileSelected(photo.path);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const ListTile(
                leading: Icon(Icons.camera_alt_rounded),
                title: Text("Select Photo"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
