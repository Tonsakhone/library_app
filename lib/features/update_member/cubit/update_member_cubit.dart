import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_member_state.dart';

class UpdateMemberCubit extends Cubit<UpdateMemberState> {
  UpdateMemberCubit() : super(Loading());

  final _firestore = FirebaseFirestore.instance.collection('members');

  Future<void> updateMember({required String memberId, required String major, required String studentId, required String phoneNumber}) async {
    try {
      emit(Loading());
      final memberDoc = _firestore.doc(memberId);
      await memberDoc.update(
        {
          "member_major": major,
          "std_id": studentId,
          "phone_number": phoneNumber,
        },
      );
      emit(Success(memberId: memberId));
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
