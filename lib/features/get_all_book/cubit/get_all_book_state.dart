part of 'get_all_book_cubit.dart';

@immutable
sealed class GetAllBookState {}

final class Loading extends GetAllBookState {}

final class Empty extends GetAllBookState {}

final class Success extends GetAllBookState {
  final List<BookModel> books;

  Success(this.books);
}

final class Failure extends GetAllBookState {
  final String message;

  Failure(this.message);
}
