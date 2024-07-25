part of 'get_all_member_cubit.dart';

@immutable
sealed class GetAllMemberState {}

final class Initial extends GetAllMemberState {}

final class Loading extends GetAllMemberState {}

final class Success extends GetAllMemberState {
  final List<MemberModel> memberModel;

  Success({required this.memberModel});
}

final class Empty extends GetAllMemberState {}

final class Failure extends GetAllMemberState {
  final String message;

  Failure(this.message);
}
