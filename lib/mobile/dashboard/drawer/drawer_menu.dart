import 'package:flutter/material.dart';

class DrawerWidgetMenu extends StatelessWidget {
  final VoidCallback onClicked;
  const DrawerWidgetMenu({super.key, required this.onClicked});

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.format_align_left),
        color: Colors.black,
        onPressed: onClicked,
      );
}
