import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_member/model/member_model.dart';

part 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(Initial());

  final memberStorage = FirebaseFirestore.instance.collection('members');

  Future<void> addMember({
    required String name,
    required String gender,
    required String major,
    required String studentId,
    required String phoneNumber,
  }) async {
    try {
      emit(Loading());

      final memberId = memberStorage.doc().id;
      final now = DateTime.now().toUtc();

      await memberStorage.doc(memberId).set(
            MemberModel(id: memberId, name: name, gender: gender, major: major, studentId: studentId, phoneNumber: phoneNumber, createAt: now)
                .toMap(),
          );
      emit(Success(memberId));
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
