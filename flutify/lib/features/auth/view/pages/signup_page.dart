import 'package:flutify/core/failure/failure.dart';
import 'package:flutify/core/utils/snack_bar_util.dart';
import 'package:flutify/core/widgets/circular_loader.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/auth_viewmodel.dart';

import '../../../../core/widgets/custom_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignpuPageState();
}

class _SignpuPageState extends ConsumerState<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(
      authViewModelProvider.select(
        (value) => value?.isLoading == true,
      ),
    );
    ref.listen(
      authViewModelProvider,
      (prev, next) {
        next?.when(
            data: (data) {
              if (prev == next) {
                return;
              }
              showInfoSnackbar(infoMessage: 'Account created Successfully1', context: context);
              context.push('/login');
            },
            error: (error, stackTrace) {
              showErrorSnackbar(failure: error as ServerFailure, context: context);
            },
            loading: () {});
      },
    );
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
                        'Hi There!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFiled(hintText: 'Name', isObscured: false, controller: _nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFiled(
                          hintText: 'Email', isObscured: false, controller: _emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFiled(
                          hintText: 'Password', isObscured: true, controller: _passwordController),
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
                              ref.read(authViewModelProvider.notifier).signupUser(
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  password: _passwordController.text);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Pallete.transparentColor,
                            foregroundColor: Pallete.whiteColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                            textStyle: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => context.push('/login'),
                        child: RichText(
                            text: const TextSpan(text: 'Already have an account ? ', children: [
                          TextSpan(
                            text: 'Log In.',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Pallete.gradient2),
                          )
                        ])),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
