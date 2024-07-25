part of 'add_staff_cubit.dart';

@immutable
sealed class AddStaffState {}

final class Loading extends AddStaffState {}

final class Success extends AddStaffState {
  final String id;

  Success({required this.id});
}

final class Failure extends AddStaffState {
  final String message;

  Failure({required this.message});
}
