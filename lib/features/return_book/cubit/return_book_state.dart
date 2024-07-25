part of 'return_book_cubit.dart';

@immutable
sealed class ReturnBookState {}

final class Loading extends ReturnBookState {}

final class Success extends ReturnBookState {
  final String rentId;

  Success({required this.rentId});
}

final class Failure extends ReturnBookState {
  final String message;

  Failure({required this.message});
}
