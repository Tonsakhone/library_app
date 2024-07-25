part of 'delete_member_cubit.dart';

@immutable
sealed class DeleteMemberState {}

final class Initial extends DeleteMemberState {}

final class Loading extends DeleteMemberState {}

final class Success extends DeleteMemberState {
  final String memberId;

  Success(this.memberId);
}

final class Failure extends DeleteMemberState {
  final String message;

  Failure(this.message);
}
