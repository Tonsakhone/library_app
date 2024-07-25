import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:libary_management/features/add_staff/model/staff_model.dart';
part 'add_staff_state.dart';

class AddStaffCubit extends Cubit<AddStaffState> {
  AddStaffCubit() : super(Loading());

  final _fireStore = FirebaseFirestore.instance.collection('staffs');

  Future<void> addStaff({
    required String fullname,
    required int staffNumber,
    required String password,
  }) async {
    try {
      emit(Loading());
      final id = _fireStore.doc().id;
      final checkStaffNumber = await _fireStore.where('staff_number', isEqualTo: staffNumber).get();

      if (checkStaffNumber.docs.isNotEmpty) {
        emit(Failure(message: 'This Staff Number is already in use. Please try a different one.'));
        return;
      }

      await _fireStore.doc(id).set(
            StaffModel(id: id, fullname: fullname, staffNumber: staffNumber, password: password).toMap(),
          );
      emit(Success(id: id));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }

  Future<void> deleteStaff({required String id}) async {
    try {
      emit(Loading());
      final staffCollection = FirebaseFirestore.instance.collection('staffs');
      final staffDoc = staffCollection.doc(id);
      await staffDoc.delete();
      emit(Success(id: id));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
