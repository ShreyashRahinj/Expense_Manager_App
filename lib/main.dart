import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vexpense/constants/routes.dart';
import 'package:vexpense/data/expense_data.dart';
import 'package:vexpense/firebase_options.dart';
import 'package:vexpense/pages/home_page.dart';
import 'package:vexpense/pages/login_page.dart';
import 'package:vexpense/pages/register_page.dart';
import 'package:vexpense/services/auth/auth_gate.dart';
import 'package:vexpense/theme/dark_theme.dart';
import 'package:vexpense/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('Expense_Database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        routes: {
          toLoginPageRoute: (context) => const LoginPage(),
          toRegisterPageRoute: (context) => const RegisterPage(),
          toHomePageRoute: (context) => const HomePage(),
        },
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const AuthGate(),
      ),
    );
  }
}
