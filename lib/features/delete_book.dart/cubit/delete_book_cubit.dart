import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_book_state.dart';

class DeleteBookCubit extends Cubit<DeleteBookState> {
  DeleteBookCubit() : super(Loading());

  Future<void> deleteBooking({required String bookId}) async {
    try {
      emit(Loading());
      final bookCollection = FirebaseFirestore.instance.collection('books');
      final bookDocument = bookCollection.doc(bookId);
      await bookDocument.delete();
      emit(Success(bookId: bookId));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
