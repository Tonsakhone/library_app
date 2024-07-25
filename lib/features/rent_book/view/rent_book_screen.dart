import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/features/rent_book/view/cubit/rent_book_cubit.dart';
import 'package:libary_management/features/rent_book/view/widget/scanner.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/custom_input_box.dart';
import 'package:intl/intl.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/loading_dialog.dart';
import 'package:libary_management/widget/success_dialog.dart';

class RentBookScreen extends StatefulWidget {
  const RentBookScreen({super.key});

  @override
  State<RentBookScreen> createState() => _RentBookScreenState();
}

class _RentBookScreenState extends State<RentBookScreen> {
  final TextEditingController stdIdController = TextEditingController();
  final TextEditingController barCodeController = TextEditingController();
  DateTime confirmRentDate = DateTime.now();
  DateTime confirmReturnDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String rentDate = DateFormat('dd-MM-yyyy').format(confirmRentDate);
    final String returnDate = DateFormat('dd-MM-yyyy').format(confirmReturnDate);
    final cubit = context.watch<RentBookCubit>();
    final barCode = cubit.qrcode;
    return BlocProvider(
      create: (context) => RentBookCubit(),
      child: BlocConsumer<RentBookCubit, RentBookState>(
        listener: (context, state) {
          if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "Successfully",
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
            failureDialog(
              context: context,
              message: state.message,
            );
          } else {
            LoadingDialog.showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Rent Book"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 38),
                  child: Column(
                    children: [
                      CustomInputBox(hander: "Student ID", controller: stdIdController),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: CustomInputBox(hander: barCode == "" ? 'Bar Code ' : barCode, controller: barCodeController)),
                          const SizedBox(width: 28),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Scanner(),
                                ),
                              ),
                              child: const Icon(Icons.barcode_reader),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(3010),
                            onConfirm: (date) {
                              setState(
                                () {
                                  confirmRentDate = date;
                                },
                              );
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.th,
                          );
                        },
                        child: Container(
                          width: size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Rent Date : $rentDate",
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(3010),
                            onConfirm: (date) {
                              setState(
                                () {
                                  confirmReturnDate = date;
                                },
                              );
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.th,
                          );
                        },
                        child: Container(
                          width: size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Return Date : $returnDate",
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: "Rent Now",
                        onPressed: () {
                          final stdId = stdIdController.text.trim();
                          final codeId = barCodeController.text.trim();
                          context.read<RentBookCubit>().rentBook(
                              stdId: stdId, barCode: barCode == "" ? codeId : barCode, rentDate: confirmRentDate, returnDate: confirmReturnDate);
                        },
                      )
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
