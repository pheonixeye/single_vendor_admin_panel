import 'package:flutter/material.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: const [
                ListTile(
                  title: Text('Create Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
