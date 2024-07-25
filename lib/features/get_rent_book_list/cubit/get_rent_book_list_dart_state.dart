part of 'get_rent_book_list_dart_cubit.dart';

@immutable
sealed class GetRentBookListDartState {}

final class Loading extends GetRentBookListDartState {}

final class Success extends GetRentBookListDartState {
  final List<RentBookModel> rentBook;

  Success({required this.rentBook});
}

final class Failure extends GetRentBookListDartState {
  final String message;

  Failure({required this.message});
}

final class Member extends GetRentBookListDartState {
  final MemberModel memberModel;

  Member({required this.memberModel});
}

final class Book extends GetRentBookListDartState {
  final BookModel bookModel;

  Book({required this.bookModel});
}
