import 'package:flutter/material.dart';

class InputView extends StatelessWidget {
  const InputView({super.key, required this.text, required this.title});
  final String text;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
      child: TextFormField(
        initialValue: text,
        enabled: false,
        style: const TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            maxHeight: 50
          ),
          labelText: title,
          labelStyle: const TextStyle(
              fontSize: 16,
            fontWeight: FontWeight.w500
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1
            )
          ),
        )
      ),
    );
  }
}
