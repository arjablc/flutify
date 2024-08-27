import 'package:flutter/material.dart';

class CustomFiled extends StatelessWidget {
  final String hintText;
  final bool isObscured;
  final TextEditingController controller;

  const CustomFiled(
      {super.key,
      required this.hintText,
      required this.isObscured,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      style: Theme.of(context).textTheme.titleSmall,
      obscureText: isObscured,
      controller: controller,
      validator: (value) {
        if (value!.trim().isNotEmpty) {
          return null;
        }
        return "All fields must be filled";
      },
    );
  }
}
