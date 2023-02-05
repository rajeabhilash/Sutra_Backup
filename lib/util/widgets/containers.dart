import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class BaseTile extends StatelessWidget {
  const BaseTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(5),
        ),
        height: 80,
      ),
    );
  }
}
