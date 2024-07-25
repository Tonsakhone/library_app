import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'update_book_state.dart';

class UpdateBookCubit extends Cubit<UpdateBookState> {
  UpdateBookCubit() : super(Loading());

  final _firestore = FirebaseFirestore.instance.collection('books');

  Future<void> updateBook({required String bookId, required String? name, required String? image, required String? barCode}) async {
    try {
      emit(Loading());
      final bookDoc = _firestore.doc(bookId);
      await bookDoc.update({
        "name": name,
        "image": image,
        "barCode": barCode,
      });
      emit(Success(bookId: bookId));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
