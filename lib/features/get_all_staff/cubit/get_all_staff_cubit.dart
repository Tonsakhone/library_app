import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_staff/model/staff_model.dart';

part 'get_all_staff_state.dart';

class GetAllStaffCubit extends Cubit<GetAllStaffState> {
  GetAllStaffCubit() : super(Loading());
  final _fireStore = FirebaseFirestore.instance.collection('staffs');

  Future<void> getAllStaffs() async {
    try {
      emit(Loading());
      final staffDoc = await _fireStore.get();
      final staff = staffDoc.docs.map((doc) => StaffModel.fromMap(doc.data())).toList();
      emit(Success(staffModel: staff));
    } on FirebaseException catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
