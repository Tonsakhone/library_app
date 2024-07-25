import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/get_rent_book_list/cubit/get_rent_book_list_dart_cubit.dart';
import 'package:libary_management/features/get_rent_book_list/widget/rent_info_line.dart';

class BookInfo extends StatelessWidget {
  final String barCode;
  const BookInfo({super.key, required this.barCode});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetRentBookListDartCubit()..fetchBookByBarCode(barCode),
      child: BlocBuilder<GetRentBookListDartCubit, GetRentBookListDartState>(
        builder: (context, state) {
          if (state is Book) {
            return Column(
              children: [
                RentInfoLine(hander: "Book Name :", detail: state.bookModel.name),
                RentInfoLine(hander: "Book BarCode :", detail: barCode),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    height: 200,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          state.bookModel.image.toString(),
                        ),
                      ),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            );
          }
          return const Text("");
        },
      ),
    );
  }
}
