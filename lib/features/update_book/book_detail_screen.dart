import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_book/model/book_model.dart';
import 'package:libary_management/features/add_book/widget/image_dialog.dart';
import 'package:libary_management/features/delete_book.dart/delete_book_dialog.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/features/update_book/cubit/update_book_cubit.dart';
import 'package:libary_management/widget/custom_input_box.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/loading_dialog.dart';
import 'package:libary_management/widget/success_dialog.dart';

import '../../widget/custom_button.dart';

class BookDetailScreen extends StatefulWidget {
  final BookModel bookModel;
  const BookDetailScreen({super.key, required this.bookModel});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController barCodeController = TextEditingController();
  String image = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UpdateBookCubit(),
      child: BlocConsumer<UpdateBookCubit, UpdateBookState>(
        listener: (context, state) {
          if (state is Failure) {
            LoadingDialog.hideLoadingDialog(context);
            failureDialog(context: context, message: state.message);
          } else if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "Updating Book Successfully",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashBoardScreen(),
                ),
              ),
            );
          } else {
            LoadingDialog.showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 214, 214),
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.bookModel.name),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => deleteBookDialog(context: context, bookId: widget.bookModel.id),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          imageDialog(
                              context: context,
                              onFileSelected: (filePath) {
                                setState(
                                  () {
                                    image = filePath!;
                                  },
                                );
                              },
                              isImageOnly: true);
                        },
                        child: Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                  image: image.isNotEmpty ? FileImage(File(image)) : NetworkImage(widget.bookModel.image ?? "") as ImageProvider,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Upload Book Picture",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 48),
                      CustomInputBox(hander: widget.bookModel.name, controller: nameController),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: CustomInputBox(hander: widget.bookModel.barCode, controller: barCodeController)),
                          const SizedBox(width: 28),
                          SizedBox(height: 50, child: ElevatedButton(onPressed: () {}, child: const Icon(Icons.barcode_reader)))
                        ],
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: "Update Book",
                        onPressed: () {
                          final name = nameController.text.trim();
                          final barCode = barCodeController.text.trim();
                          context.read<UpdateBookCubit>().updateBook(
                                bookId: widget.bookModel.id,
                                name: name == "" ? widget.bookModel.name : name,
                                image: image == "" ? widget.bookModel.image : image,
                                barCode: barCode == "" ? widget.bookModel.barCode : barCode,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
