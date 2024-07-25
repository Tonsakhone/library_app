import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_staff/view/add_staff_screen.dart';
import 'package:libary_management/features/add_staff/view/widget/add_new_form.dart';
import 'package:libary_management/features/get_all_staff/cubit/get_all_staff_cubit.dart';
import 'package:libary_management/features/get_all_staff/view/widget/get_all_staff_success.dart';

class GetAllStaffScreen extends StatelessWidget {
  const GetAllStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetAllStaffCubit()..getAllStaffs(),
      child: BlocBuilder<GetAllStaffCubit, GetAllStaffState>(
        builder: (context, state) {
          if (state is Success) {
            if (state.staffModel.isEmpty) {
              return AddNewForm();
            } else {
              return GetAllStaffSuccess(staff: state.staffModel);
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
            return const AddStaffScreen();
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
