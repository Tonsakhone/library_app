part of 'add_member_cubit.dart';

@immutable
sealed class AddMemberState {}

final class Initial extends AddMemberState {}

final class Loading extends AddMemberState {}

final class Success extends AddMemberState {
  final String id;

  Success(this.id);
}

final class Failure extends AddMemberState {
  final String message;

  Failure(this.message);
}
