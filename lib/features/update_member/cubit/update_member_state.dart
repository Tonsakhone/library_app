part of 'update_member_cubit.dart';

@immutable
sealed class UpdateMemberState {}

final class Loading extends UpdateMemberState {}

final class Success extends UpdateMemberState {
  final String memberId;

  Success({required this.memberId});
}

final class Failure extends UpdateMemberState {
  final String message;

  Failure(this.message);
}
