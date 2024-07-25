import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:libary_management/features/get_rent_book_list/cubit/get_rent_book_list_dart_cubit.dart';
import 'package:libary_management/features/get_rent_book_list/widget/rent_book_detail.dart';
import 'package:libary_management/features/rent_book/view/rent_book_screen.dart';

class GetRentBookListScreen extends StatelessWidget {
  const GetRentBookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetRentBookListDartCubit()..getAllRent(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("All Rents"),
        ),
        body: BlocBuilder<GetRentBookListDartCubit, GetRentBookListDartState>(
          builder: (context, state) {
            if (state is Success) {
              if (state.rentBook.isEmpty) {
                return const RentBookScreen();
              } else {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ListView.builder(
                    itemCount: state.rentBook.length,
                    itemBuilder: (context, index) {
                      final rentBook = state.rentBook[index];
                      final String rentDate = DateFormat('dd-MM-yyyy').format(rentBook.rentAt);
                      final String returnDate = DateFormat('dd-MM-yyyy').format(rentBook.returnAt);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RentBookDetail(rentBook: rentBook),
                            ),
                          ),
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text("STD : ${rentBook.studentId}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("BarCode : ${rentBook.barCode}"),
                                  Text("Rent Date : $rentDate"),
                                  Text("Return Date : $returnDate"),
                                ],
                              ),
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage("assets/book-stack.png"),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            } else if (state is Failure) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Center(
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Loading..."),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
