import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../add_member/model/member_model.dart';

part 'get_all_member_state.dart';

class GetAllMemberCubit extends Cubit<GetAllMemberState> {
  GetAllMemberCubit() : super(Initial());

  final memberStorage = FirebaseFirestore.instance.collection('members');

  Future<void> getAllMember() async {
    try {
      emit(Loading());
      final memberDoc = await memberStorage.get();
      final member = memberDoc.docs.map((doc) => MemberModel.fromMap(doc.data())).toList();
      if (member.isEmpty) {
        emit(Empty());
      } else {
        emit(Success(memberModel: member));
      }
    } on FirebaseException catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
