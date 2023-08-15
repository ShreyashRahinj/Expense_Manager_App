import 'package:flutter/material.dart';
import 'package:vexpense/components/custom_dialog.dart';
import 'package:vexpense/constants/routes.dart';
import 'package:vexpense/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late final AuthService _auth;

  @override
  void initState() {
    _auth = AuthService();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    try {
      loadingScreen(context: context);
      await _auth.signIn(usernameController.text, passwordController.text);
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
            GestureDetector(
              onTap: login,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                  child: Text(
                    'Sign In',
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
                const Text('Not a User?'),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, toRegisterPageRoute, (route) => false),
                  child: const Text(
                    'Register',
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
