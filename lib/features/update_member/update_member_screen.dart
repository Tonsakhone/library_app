import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_member/model/member_model.dart';
import 'package:libary_management/features/add_member/view/widget/phone_input.dart';
import 'package:libary_management/features/add_member/view/widget/student_id_input.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/features/update_member/cubit/update_member_cubit.dart';
import 'package:libary_management/widget/loading_dialog.dart';
import 'package:libary_management/widget/read_inpit_box.dart';
import 'package:libary_management/widget/success_dialog.dart';

import '../../../widget/failure_dialog.dart';

class UpdateMemberScreen extends StatefulWidget {
  final MemberModel member;
  const UpdateMemberScreen({super.key, required this.member});

  @override
  State<UpdateMemberScreen> createState() => _UpdateMemberScreenState();
}

class _UpdateMemberScreenState extends State<UpdateMemberScreen> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedMajor = "Select a Major";
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => UpdateMemberCubit(),
      child: BlocConsumer<UpdateMemberCubit, UpdateMemberState>(
        listener: (context, state) {
          if (state is Success) {
            LoadingDialog.hideLoadingDialog(context);
            successDialog(
              context: context,
              message: "Updating a Membership Successfully",
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
              title: const Text("Update Membership"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      child: Column(
                        children: [
                          ReadInputBox(hander: widget.member.name),
                          const SizedBox(height: 18),
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedMajor,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Select a Major',
                                    child: Text('Select a Major', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'IT',
                                    child: Text('IT', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'ITB',
                                    child: Text('ITB', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'English',
                                    child: Text('English', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Business Administration',
                                    child: Text('Business Administration', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Financial and Accounting',
                                    child: Text('Financial and Accounting', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedMajor = value.toString();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          StudentIdInput(hander: widget.member.studentId, controller: studentIdController),
                          const SizedBox(height: 18),
                          PhoneInput(hander: widget.member.phoneNumber, controller: phoneNumberController),
                          const SizedBox(height: 60),
                          SizedBox(
                            height: 60,
                            width: size.width,
                            child: ElevatedButton(
                              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                              onPressed: () {
                                final studentId = studentIdController.text.trim();
                                final phoneNumber = phoneNumberController.text.trim();
                                context
                                    .read<UpdateMemberCubit>()
                                    .updateMember(memberId: widget.member.id, major: selectedMajor, studentId: studentId, phoneNumber: phoneNumber);
                              },
                              child: const Text(
                                "Update",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
