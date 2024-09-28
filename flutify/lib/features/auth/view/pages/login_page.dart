import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/failure/failure.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../models/user_model.dart';
import '../../../../core/widgets/circular_loader.dart';
import '../../../../core/utils/snack_bar_util.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/widgets/custom_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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
    final bool isLoading = ref.watch(authViewModelProvider.select(
      (value) => value?.isLoading == true,
    ));
    ref.listen(authViewModelProvider, (prev, next) {
      next?.when(
          data: (UserModel data) {
            //TODO: add navigation to home page
            showInfoSnackbar(
                infoMessage: 'Successfully logged in as ${data.name}',
                context: context);
            context.go('/home');
          },
          error: (dynamic error, StackTrace stackTrace) {
            if (error.runtimeType == ServerFailure) {
              showErrorSnackbar(failure: error, context: context);
            }
          },
          loading: () {});
    });
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? const Center(child: CustomLoader())
            : Form(
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
                      CustomField(
                          hintText: 'Email',
                          isObscured: false,
                          controller: _emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomField(
                          hintText: 'Password',
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
                              ref
                                  .read(authViewModelProvider.notifier)
                                  .loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                            }
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
                        onTap: () => context.push('/signup'),
                        child: RichText(
                            text: const TextSpan(
                                text: "Don't have an account? ",
                                children: [
                              TextSpan(
                                  text: 'Create one.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Pallete.gradient2))
                            ])),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
