import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
part 'return_book_state.dart';

class ReturnBookCubit extends Cubit<ReturnBookState> {
  ReturnBookCubit() : super(Loading());

  Future<void> deleteBooking({required String rentId}) async {
    try {
      emit(Loading());
      final rentCollection = FirebaseFirestore.instance.collection('rents');
      final rentDoc = rentCollection.doc(rentId);
      await rentDoc.delete();
      emit(Success(rentId: rentId));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
