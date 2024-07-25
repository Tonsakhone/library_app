import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_staff/view/widget/add_new_form.dart';
import 'package:libary_management/features/add_staff/view/widget/add_staff_form.dart';
import 'package:libary_management/features/get_all_staff/cubit/get_all_staff_cubit.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetAllStaffCubit()..getAllStaffs(),
      child: BlocBuilder<GetAllStaffCubit, GetAllStaffState>(
        builder: (context, state) {
          if (state is Success) {
            if (state.staffModel.isNotEmpty) {
              return AddStaffForm(data: state.staffModel);
            } else {
              return AddNewForm();
            }
          } else if (state is Failure) {
            return Scaffold(
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Center(
                  child: Text(state.message),
                ),
              ),
            );
          } else if (state is Empty) {
            return AddNewForm();
          }
          return Scaffold(
            body: SizedBox(
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
            ),
          );
        },
      ),
    );
  }
}
