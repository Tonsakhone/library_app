import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:libary_management/features/get_rent_book_list/cubit/get_rent_book_list_dart_cubit.dart';
import 'package:libary_management/features/get_rent_book_list/widget/book_info.dart';
import 'package:libary_management/features/get_rent_book_list/widget/rent_info_line.dart';
import 'package:libary_management/features/get_rent_book_list/widget/student_info.dart';
import 'package:libary_management/features/rent_book/model/rent_book_model.dart';
import 'package:libary_management/features/return_book/confirm_return_book.dart';
import 'package:libary_management/widget/custom_button.dart';

class RentBookDetail extends StatelessWidget {
  final RentBookModel rentBook;
  const RentBookDetail({super.key, required this.rentBook});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String rentDate = DateFormat('dd-MM-yyyy').format(rentBook.rentAt);
    final String returnDate = DateFormat('dd-MM-yyyy').format(rentBook.returnAt);
    return BlocProvider(
      create: (context) => GetRentBookListDartCubit()..fetchMemberByStudentId(rentBook.studentId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rent Book Detail'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            RentInfoLine(hander: "Rent Date :", detail: rentDate),
                            RentInfoLine(hander: "Return Date :", detail: returnDate),
                            StudentInfo(studentId: rentBook.studentId),
                            RentInfoLine(hander: "Rent By ID :", detail: rentBook.studentId),
                            BookInfo(barCode: rentBook.barCode),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: "Return",
                    onPressed: () => confirmReturnBook(context: context, rentId: rentBook.id),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
