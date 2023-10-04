import 'package:flutter/material.dart';

class ImagesEditComponent extends StatelessWidget {
  const ImagesEditComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Edit Images'),
                  tileColor: Colors.green.shade200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}