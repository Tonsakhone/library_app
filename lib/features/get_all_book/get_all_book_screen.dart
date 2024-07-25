import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/get_all_book/cubit/get_all_book_cubit.dart';
import 'package:libary_management/features/update_book/book_detail_screen.dart';

class GetAllBookScreen extends StatelessWidget {
  const GetAllBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetAllBookCubit()..getAllBook(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("All Books"),
        ),
        body: BlocBuilder<GetAllBookCubit, GetAllBookState>(
          builder: (context, state) {
            if (state is Loading) {
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
            } else if (state is Empty) {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: const Center(
                  child: Text("No Member Data"),
                ),
              );
            } else if (state is Success) {
              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 350,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(bookModel: state.books[index]),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          width: 230,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(image: NetworkImage(state.books[index].image ?? ""), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is Failure) {
              return SizedBox(
                width: size.width,
                height: size.height,
                child: const Center(
                  child: Text("No Member Data"),
                ),
              );
            }
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
          },
        ),
      ),
    );
  }
}
