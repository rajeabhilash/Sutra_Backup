import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    super.key,
    required this.imagePath,
    required this.onClicked,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildCircle(
              all: 4,
              color: Theme.of(context).primaryColor,
              child: buildImage()),
          Positioned(
            bottom: 10,
            right: 10,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = imagePath.contains('https')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 250,
          height: 250,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(color) => buildCircle(
        color: Colors.white,
        all: 4,
        child: buildCircle(
          color: color,
          all: 10,
          child: Icon(
            isEdit ? Icons.add_a_photo_rounded : Icons.edit,
            size: 30,
            color: Colors.white,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
