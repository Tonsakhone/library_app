import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/delete_member/delete_member_dialog.dart';
import 'package:libary_management/features/get_all_member/view/cubit/get_all_member_cubit.dart';
import 'package:libary_management/features/update_member/update_member_screen.dart';

class GetAllMemberScreen extends StatelessWidget {
  const GetAllMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetAllMemberCubit()..getAllMember(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("All Members"),
        ),
        body: BlocBuilder<GetAllMemberCubit, GetAllMemberState>(
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
              return SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: state.memberModel.length,
                  itemBuilder: (context, index) {
                    final member = state.memberModel[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(member.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender : ${member.gender}"),
                              Text("Student Id : ${member.studentId}"),
                              Text("Id : ${member.id}"),
                              Text("Major : ${member.major}"),
                            ],
                          ),
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage("assets/profile.png"),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 5,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Call",
                                                      style: TextStyle(color: Colors.blue),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Icon(Icons.phone, color: Colors.blue),
                                                  ],
                                                )),
                                          ),
                                          Card(
                                            elevation: 5,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => UpdateMemberScreen(member: member),
                                                    ),
                                                  );
                                                },
                                                icon: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Update",
                                                      style: TextStyle(color: Colors.green),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Icon(Icons.edit, color: Colors.green),
                                                  ],
                                                )),
                                          ),
                                          Card(
                                            elevation: 5,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  deleteMemberDialog(context: context, memberId: member.id);
                                                },
                                                icon: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Delete",
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                    SizedBox(width: 12),
                                                    Icon(Icons.delete, color: Colors.red),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.more, color: Colors.lightBlue)),
                        ),
                      ),
                    );
                  },
                ),
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
