part of 'update_book_cubit.dart';

@immutable
sealed class UpdateBookState {}

final class Loading extends UpdateBookState {}

final class Success extends UpdateBookState {
  final String bookId;

  Success({required this.bookId});
}

final class Failure extends UpdateBookState {
  final String message;

  Failure({required this.message});
}
