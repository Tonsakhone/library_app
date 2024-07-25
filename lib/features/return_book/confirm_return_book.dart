import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/features/return_book/cubit/return_book_cubit.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/loading_dialog.dart';
import 'package:libary_management/widget/success_dialog.dart';

confirmReturnBook({required BuildContext context, required String rentId}) {
  return showDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => ReturnBookCubit(),
      child: BlocConsumer<ReturnBookCubit, ReturnBookState>(
        listener: (context, state) {
          if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "You have successfully Return Rent Book ID : $rentId",
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
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Are You Sure?"),
                  const SizedBox(height: 8),
                  const Text("You are returning a book"),
                  const SizedBox(height: 18),
                  CustomButton(
                    text: "Confirm",
                    onPressed: () {
                      context.read<ReturnBookCubit>().deleteBooking(rentId: rentId);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
