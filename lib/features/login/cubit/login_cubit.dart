import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libary_management/features/add_staff/model/staff_model.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(Loading());

   final _firestore = FirebaseFirestore.instance.collection('staffs');

  Future<void> login(int staffNumber, String password) async {
    emit(Loading());

    try {
      final userQuery =
          await _firestore.where('staff_number', isEqualTo: staffNumber).get();
      final passwordQuery =
          await _firestore.where('password', isEqualTo: password).get();

      if (userQuery.docs.isEmpty || passwordQuery.docs.isEmpty) {
        emit(Failure( message: 
            "ເບີໂທລະສັບ ຫຼື ລະຫັດຜ່ານຂອງທ່ານບໍ່ຖືກຕ້ອງ!!!."));
        return;
      }

      final userDoc = userQuery.docs.first;

      final staff = StaffModel.fromMap(userDoc.data());
      emit(Success(staffModel: staff));
    } catch (error) {
      emit(Failure(message:  error.toString()));
    }
  }
}
