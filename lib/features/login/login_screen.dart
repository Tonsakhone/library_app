import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/add_staff/view/widget/password_input.dart';
import 'package:libary_management/features/desh_board/view/dash_board_screen.dart';
import 'package:libary_management/features/login/cubit/login_cubit.dart';
import 'package:libary_management/widget/custom_button.dart';
import 'package:libary_management/widget/custom_input_box.dart';
import 'package:libary_management/widget/failure_dialog.dart';
import 'package:libary_management/widget/loading_dialog.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final staffNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
         if(state is Success){
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardScreen(),));
         }else if(state is Failure){
          LoadingDialog.hideLoadingDialog(context);
          failureDialog(context: context, message: state.message);
         }else{
          LoadingDialog.showLoadingDialog(context);
         }
        },
        builder: (context, state) {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomInputBox(
                                  hander: "Staff Number",
                                  controller: staffNumberController,
                                ),
                                const SizedBox(height: 30),
                                PasswordInput(
                                  hander: "Password",
                                  controller: passwordController,
                                  closePassword: true,
                                ),
                                const SizedBox(height: 60),
                                CustomButton(
                                  text: "Login",
                                  onPressed: () {
                                      final staffNumber = staffNumberController.text.trim();
                                      final number = int.parse(staffNumber);
                                      final password = passwordController.text.trim();

                                      context.read<LoginCubit>().login(number, password);
                                    
                                  },
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
