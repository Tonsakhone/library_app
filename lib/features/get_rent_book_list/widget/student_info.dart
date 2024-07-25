import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/get_rent_book_list/cubit/get_rent_book_list_dart_cubit.dart';
import 'package:libary_management/features/get_rent_book_list/widget/rent_info_line.dart';

class StudentInfo extends StatelessWidget {
  final String studentId;
  const StudentInfo({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetRentBookListDartCubit()..fetchMemberByStudentId(studentId),
      child: BlocBuilder<GetRentBookListDartCubit, GetRentBookListDartState>(
        builder: (context, state) {
          if (state is Member) {
            return RentInfoLine(hander: "Rent By :", detail: state.memberModel.name);
          }
          return const Text("");
        },
      ),
    );
  }
}
