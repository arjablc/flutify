import 'package:flutify/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFiled(
                    hintText: "Email",
                    isObscured: false,
                    controller: emailController),
                const SizedBox(
                  height: 10,
                ),
                CustomFiled(
                    hintText: "Password",
                    isObscured: true,
                    controller: passwordController),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Pallete.gradient1,
                        Pallete.gradient3,
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Pallete.transparentColor,
                      foregroundColor: Pallete.whiteColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14),
                      textStyle: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    child: const Text(
                      'Login',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: Theme.of(context).textTheme.titleSmall),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
