import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_book/model/book_model.dart';

part 'add_book_state.dart';

class AddBookCubit extends Cubit<AddBookState> {
  AddBookCubit() : super(Loading());

  final _fireStore = FirebaseFirestore.instance.collection('books');

  Future<void> addBook({required String name, required String barCode, required String image}) async {
    try {
      emit(Loading());
      final id = _fireStore.doc().id;
      final bookImage = await uploadImage(image);

      await _fireStore.doc(id).set(
            BookModel(id: id, name: name, image: bookImage, barCode: barCode).toMap(),
          );
      emit(Success(id));
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<String> uploadImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!file.existsSync()) {
        throw Exception("File does not exist at the provided path: $imagePath");
      }
      final reference = FirebaseStorage.instance.ref().child('books_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = reference.putFile(file);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        debugPrint('Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      });
      await uploadTask;
      final url = await reference.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      debugPrint('\x1B[31m$e\x1B[0m');
      throw Exception('Error uploading image: ${e.message}');
    }
  }
}
