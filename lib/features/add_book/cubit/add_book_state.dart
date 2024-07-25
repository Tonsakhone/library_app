part of 'add_book_cubit.dart';

@immutable
sealed class AddBookState {}

final class Loading extends AddBookState {}

final class Success extends AddBookState {
  final String bookId;

  Success(this.bookId);
}

final class Failure extends AddBookState {
  final String message;

  Failure(this.message);
}
