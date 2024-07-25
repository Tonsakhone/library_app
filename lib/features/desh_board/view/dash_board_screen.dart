import 'package:flutter/material.dart';
import 'package:libary_management/features/add_book/add_book_screen.dart';
import 'package:libary_management/features/add_member/view/add_member_screen.dart';
import 'package:libary_management/features/add_staff/view/add_staff_screen.dart';
import 'package:libary_management/features/desh_board/view/widget/custom_drawer.dart';
import 'package:libary_management/features/desh_board/view/widget/menu_box.dart';
import 'package:libary_management/features/rent_book/view/rent_book_screen.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 214, 214),
        appBar: AppBar(
          title: const Text("DashBoard"),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MenuBox(
                          title: "Member",
                          image: "assets/user.png",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddMemberScreen(),
                            ),
                          ),
                          textColor: Colors.white,
                          backgroundColors: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: MenuBox(
                          title: "Book",
                          image: "assets/book-stack.png",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddBookScreen(),
                            ),
                          ),
                          textColor: Colors.white,
                          backgroundColors: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: MenuBox(
                          title: "Rent Book",
                          image: "assets/for-rent.png",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RentBookScreen(),
                              )),
                          textColor: Colors.white,
                          backgroundColors: Colors.purple,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: MenuBox(
                          title: "Staff",
                          image: "assets/teamwork.png",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddStaffScreen(),
                            ),
                          ),
                          textColor: Colors.white,
                          backgroundColors: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
