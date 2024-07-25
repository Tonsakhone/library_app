import 'package:flutter/material.dart';
import 'package:libary_management/features/add_staff/model/staff_model.dart';
import 'package:libary_management/features/get_all_staff/view/widget/delete_staff_dialog.dart';

class GetAllStaffSuccess extends StatelessWidget {
  final List<StaffModel> staff;
  const GetAllStaffSuccess({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Staff"),
      ),
      body: ListView.builder(
        itemCount: staff.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: Card(
              elevation: 4,
              child: ListTile(
                title: Text(
                  staff[index].fullname,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Staff Number : ${staff[index].staffNumber}",
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: IconButton(
                  onPressed: () => deleteStaffDialog(context: context, id: staff[index].id),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
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
