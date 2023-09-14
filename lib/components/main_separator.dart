import 'package:flutter/material.dart';

class MainSeparator extends StatelessWidget {
  const MainSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 2,
        color: Colors.black,
      ),
    );
  }
}
