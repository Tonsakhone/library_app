import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_member_state.dart';

class DeleteMemberCubit extends Cubit<DeleteMemberState> {
  DeleteMemberCubit() : super(Initial());

  Future<void> deleteMember({required String memberId}) async {
    try {
      emit(Loading());
      final verificationCollection = FirebaseFirestore.instance.collection('members');
      final verificationDoc = verificationCollection.doc(memberId);
      await verificationDoc.delete();
      emit(Success(memberId));
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
