import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libary_management/features/get_rent_book_list/cubit/get_rent_book_list_dart_cubit.dart';
import 'package:libary_management/features/login/cubit/login_cubit.dart';
import 'package:libary_management/features/login/login_screen.dart';
import 'package:libary_management/features/rent_book/view/cubit/rent_book_cubit.dart';
import 'package:libary_management/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  return runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RentBookCubit(),
        ),
        BlocProvider(
          create: (context) => GetRentBookListDartCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Times New Roman',
        ),
        home:  LoginScreen(),
      ),
    );
  }
}
