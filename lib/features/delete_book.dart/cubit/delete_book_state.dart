part of 'delete_book_cubit.dart';

@immutable
sealed class DeleteBookState {}

final class Loading extends DeleteBookState {}

final class Success extends DeleteBookState {
  final String bookId;

  Success({required this.bookId});
}

final class Failure extends DeleteBookState {
  final String message;

  Failure({required this.message});
}
