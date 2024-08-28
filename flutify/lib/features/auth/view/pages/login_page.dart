import 'package:flutify/core/theme/app_pallete.dart';
import 'package:flutify/features/auth/repository/auth_remote_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
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
                    controller: _emailController),
                const SizedBox(
                  height: 10,
                ),
                CustomFiled(
                    hintText: "Password",
                    isObscured: true,
                    controller: _passwordController),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthRemoteRepository().loginUser(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                      ;
                    },
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
                GestureDetector(
                  onTap: () => context.go('/signup'),
                  child: RichText(
                      text: const TextSpan(
                          text: "Don't have an account? ",
                          children: [
                        TextSpan(
                            text: "Create one.",
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
