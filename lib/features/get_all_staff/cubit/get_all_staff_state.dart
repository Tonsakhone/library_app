part of 'get_all_staff_cubit.dart';

@immutable
sealed class GetAllStaffState {}

final class Loading extends GetAllStaffState {}

final class Success extends GetAllStaffState {
  final List<StaffModel> staffModel;

  Success({required this.staffModel});
}

final class Empty extends GetAllStaffState {}

final class Failure extends GetAllStaffState {
  final String message;

  Failure({required this.message});
}
