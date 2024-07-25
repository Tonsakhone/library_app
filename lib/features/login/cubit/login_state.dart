part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class Loading extends LoginState {}
final class Success extends LoginState {
  final StaffModel staffModel;

  Success({required this.staffModel});
}
final class Failure extends LoginState {
  final String message;

  Failure({required this.message});
}
