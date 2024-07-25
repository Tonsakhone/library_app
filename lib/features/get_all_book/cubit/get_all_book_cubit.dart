import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_book/model/book_model.dart';

part 'get_all_book_state.dart';

class GetAllBookCubit extends Cubit<GetAllBookState> {
  GetAllBookCubit() : super(Loading());

  final _fireStore = FirebaseFirestore.instance.collection('books');

  Future<void> getAllBook() async {
    try {
      emit(Loading());
      final bookDoc = await _fireStore.get();
      final book = bookDoc.docs.map((doc) => BookModel.fromMap(doc.data())).toList();
      if (book.isEmpty) {
        emit(Empty());
      } else {
        emit(Success(book));
      }
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
