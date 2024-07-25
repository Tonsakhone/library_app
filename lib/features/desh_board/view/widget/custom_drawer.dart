import 'package:flutter/material.dart';
import 'package:libary_management/features/get_all_book/get_all_book_screen.dart';
import 'package:libary_management/features/get_all_member/view/get_all_member_screen.dart';
import 'package:libary_management/features/get_all_staff/view/get_all_staff_screen.dart';
import 'package:libary_management/features/get_rent_book_list/get_rent_book_list_screen.dart';
import 'package:libary_management/features/login/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    image: const DecorationImage(
                      image: AssetImage('assets/profile.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tonsakhone Ton",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),
                        label: const Icon(Icons.logout),
                        icon: const Text("Sign Out"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetAllMemberScreen(),
                ),
              );
            },
            leading: const Icon(Icons.person),
            title: const Text(
              "All Members",
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetAllBookScreen(),
                ),
              );
            },
            leading: const Icon(Icons.book),
            title: const Text(
              "All Books",
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetAllStaffScreen(),
                ),
              );
            },
            leading: const Icon(Icons.person),
            title: const Text(
              "All Staffs",
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetRentBookListScreen(),
                ),
              );
            },
            leading: const Icon(Icons.book),
            title: const Text(
              "All Rents",
            ),
          ),
        ],
      ),
    );
  }
}
