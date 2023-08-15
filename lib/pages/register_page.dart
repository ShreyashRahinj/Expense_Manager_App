import 'package:flutter/material.dart';
import 'package:vexpense/components/custom_dialog.dart';
import 'package:vexpense/constants/routes.dart';
import 'package:vexpense/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  late final AuthService _authService;

  @override
  void initState() {
    _authService = AuthService();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  void register() async {
    if (passwordController.text == cpasswordController.text &&
        passwordController.text.length >= 8) {
      try {
        loadingScreen(context: context);
        await _authService.createUser(
            usernameController.text, passwordController.text);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(toHomePageRoute, (route) => false);
      } on Exception catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Authentication failed'),
                content: Text(e.toString()),
              );
            });
      }
    } else if (passwordController.text.length < 8) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Authentication failed'),
              content: Text('Password too short'),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Authentication failed'),
              content: Text('Password and Confirm Password do not match'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wallet,
              size: 100,
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: usernameController,
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                hintText: 'Username',
                fillColor: Theme.of(context).highlightColor,
                filled: true,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                hintText: 'Password',
                fillColor: Theme.of(context).highlightColor,
                filled: true,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: cpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                hintText: 'Confirm Password',
                fillColor: Theme.of(context).highlightColor,
                filled: true,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: register,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already a User?'),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, toLoginPageRoute, (route) => false),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
