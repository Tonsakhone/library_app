import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_staff/model/staff_model.dart';
import 'package:libary_management/features/add_staff/view/cubit/add_staff_cubit.dart';
import 'package:libary_management/features/add_staff/view/widget/number_input.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/custom_input_box.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/loading_dialog.dart';
import 'package:libary_management/widget/success_dialog.dart';

class AddStaffForm extends StatelessWidget {
  final List<StaffModel> data;
  AddStaffForm({super.key, required this.data});

  final TextEditingController staffNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final latestStaffNumber = data.last.staffNumber;
    return BlocProvider(
      create: (context) => AddStaffCubit(),
      child: BlocConsumer<AddStaffCubit, AddStaffState>(
        listener: (context, state) {
          if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "Create a new Staff Account Successfully",
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
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Create a new staff"),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 58),
                  child: Column(
                    children: [
                      NumberInput(
                        label: "${latestStaffNumber + 1}",
                        controller: staffNumberController,
                        readOnly: true,
                      ),
                      const SizedBox(height: 18),
                      CustomInputBox(hander: "Fullname", controller: nameController),
                      const SizedBox(height: 18),
                      CustomInputBox(hander: "Password", controller: passwordController),
                      const SizedBox(height: 35),
                      CustomButton(
                        text: "Create",
                        onPressed: () {
                          final fullname = nameController.text.trim();
                          final password = passwordController.text.trim();
                          context.read<AddStaffCubit>().addStaff(fullname: fullname, staffNumber: latestStaffNumber + (1), password: password);
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
