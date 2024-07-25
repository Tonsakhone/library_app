import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:libary_management/features/rent_book/model/rent_book_model.dart';

part 'rent_book_state.dart';

class RentBookCubit extends Cubit<RentBookState> {
  RentBookCubit() : super(Loading());

  String qrcode = "";

  final _rentStore = FirebaseFirestore.instance.collection('rents');
  final _memberStore = FirebaseFirestore.instance.collection('members');

  Future<void> rentBook({required String stdId, required String barCode, required DateTime rentDate, required DateTime returnDate}) async {
    await checkMemberId(stdId: stdId, barCode: barCode, rentDate: rentDate, returnDate: returnDate);
  }

  Future<void> qrScanner({required String id}) async {
    try {
      emit(Loading());
      await Future.delayed(const Duration(seconds: 2));
      qrcode = id;
      emit(Success(qrcode));
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> checkMemberId({required String stdId, required String barCode, required DateTime rentDate, required DateTime returnDate}) async {
    try {
      emit(Loading());
      final exitedMemberId = await _memberStore.where("std_id", isEqualTo: stdId).get();
      final rentId = _rentStore.doc().id;
      await _rentStore.doc(rentId).set(
            RentBookModel(
              id: rentId,
              studentId: stdId,
              barCode: barCode,
              rentAt: rentDate,
              returnAt: returnDate,
            ).toMap(),
          );
      if (exitedMemberId.docs.isEmpty) {
        emit(Failure("This Student ID is not available"));
      } else {
        emit(Success(rentId));
        qrcode == "";
      }
    } on FirebaseException catch (e) {
      emit(Failure(e.message.toString()));
    }
  }
}
