part of 'rent_book_cubit.dart';

@immutable
sealed class RentBookState {}

final class Loading extends RentBookState {}

final class Success extends RentBookState {
  final String id;

  Success(this.id);
}

final class Failure extends RentBookState {
  final String message;

  Failure(this.message);
}
