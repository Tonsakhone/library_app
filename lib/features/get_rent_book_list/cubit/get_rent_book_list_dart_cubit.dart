import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_book/model/book_model.dart';
import 'package:libary_management/features/add_member/model/member_model.dart';
import 'package:libary_management/features/rent_book/model/rent_book_model.dart';
import 'package:flutter/material.dart';
part 'get_rent_book_list_dart_state.dart';

class GetRentBookListDartCubit extends Cubit<GetRentBookListDartState> {
  GetRentBookListDartCubit() : super(Loading());

  final memberStorage = FirebaseFirestore.instance.collection('members');
  final bookStorage = FirebaseFirestore.instance.collection('books');
  final rentStorage = FirebaseFirestore.instance.collection('rents');

  Future<void> fetchMemberByStudentId(String studentId) async {
    try {
      emit(Loading());
      final checkStudentID = await memberStorage.where('std_id', isEqualTo: studentId).get();

      if (checkStudentID.docs.isEmpty) {
        emit(Failure(message: "No member found with studentId $studentId"));
        return;
      }

      final memberData = checkStudentID.docs.first.data();
      final memeberdata = MemberModel.fromMap(memberData);
      emit(Member(memberModel: memeberdata));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.message.toString()));
    }
  }

  Future<void> fetchBookByBarCode(String barCode) async {
    try {
      emit(Loading());
      final checkBarCode = await bookStorage.where('barCode', isEqualTo: barCode).get();

      if (checkBarCode.docs.isEmpty) {
        emit(Failure(message: "No Book found with BarCode $barCode"));
        return;
      }

      final book = checkBarCode.docs.first.data();
      final bookData = BookModel.fromMap(book);
      emit(Book(bookModel: bookData));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.message.toString()));
    }
  }

  Future<void> getAllRent() async {
    try {
      emit(Loading());
      final querySnapshot = await rentStorage.get();
      final rentBooks = querySnapshot.docs.map((doc) => RentBookModel.fromMap(doc.data())).toList();
      if (rentBooks.isEmpty) {
        emit(Success(rentBook: rentBooks));
      } else {
        emit(Success(rentBook: rentBooks));
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message.toString());
      emit(Failure(message: e.message.toString()));
    } catch (e) {
      debugPrint(e.toString());
      emit(Failure(message: e.toString()));
    }
  }
}
