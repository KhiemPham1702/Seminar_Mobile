import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Record'),
      ),

      body: Center(
        child: Text('Text của bạn: $text' , style: const TextStyle(
          fontSize: 20
        ),)
      ),
    );
  }
}
