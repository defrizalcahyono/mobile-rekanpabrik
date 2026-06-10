import 'package:flutter/material.dart';
import 'package:rekanpabrik/shared/shared.dart';

class PassInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isEror;

  const PassInput({
    super.key,
    required this.controller,
    required this.isEror,
  });

  @override
  _PassInputState createState() => _PassInputState();
}

class _PassInputState extends State<PassInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // Menghubungkan controller
      obscureText: _obscureText, // Kontrol visibilitas password
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, size: 20),
        labelText: 'Password',
        labelStyle: TextStyle(color: greyColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: widget.isEror ? Colors.red : thirdColor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
              color: widget.isEror ? Colors.red : thirdColor, width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle visibilitas password
            });
          },
        ),
      ),
    );
  }
}
