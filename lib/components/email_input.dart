import 'package:flutter/material.dart';
import 'package:rekanpabrik/shared/shared.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;
  final bool isEror;

  const EmailInput({
    super.key,
    required this.emailController,
    required this.isEror,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          size: 20,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          color: greyColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isEror ? Colors.red : thirdColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: isEror ? Colors.red : thirdColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
