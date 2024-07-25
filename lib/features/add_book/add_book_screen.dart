import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_book/cubit/add_book_cubit.dart';
import 'package:libary_management/features/add_book/widget/image_dialog.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/custom_input_box.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/success_dialog.dart';

import '../../widget/loading_dialog.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController barCodeController = TextEditingController();
  String image = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddBookCubit(),
      child: BlocConsumer<AddBookCubit, AddBookState>(
        listener: (context, state) {
          if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "Create a new Book Successfully",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashBoardScreen(),
                  ),
                );
              },
            );
          } else if (state is Failure) {
            LoadingDialog.hideLoadingDialog(context);
            failureDialog(context: context, message: state.message);
          } else {
            LoadingDialog.showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 214, 214),
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Add a new Book"),
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
                                setState(() {
                                  image = filePath!;
                                });
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
                                  image: image.isNotEmpty ? FileImage(File(image)) : const AssetImage("assets/book_pic.jpg") as ImageProvider,
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Upload Book Picture",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 48),
                      CustomInputBox(hander: 'Book Name ', controller: nameController),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: CustomInputBox(hander: 'Bar Code ', controller: barCodeController)),
                          const SizedBox(width: 28),
                          SizedBox(height: 50, child: ElevatedButton(onPressed: () {}, child: const Icon(Icons.barcode_reader)))
                        ],
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                          text: "Add New Book",
                          onPressed: () {
                            final name = nameController.text.trim();
                            final barCode = barCodeController.text.trim();
                            context.read<AddBookCubit>().addBook(name: name, barCode: barCode, image: image);
                          })
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
