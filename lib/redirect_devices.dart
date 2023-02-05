import 'package:flutter/material.dart';

class RedirectDevice extends StatelessWidget {
  final Widget mobileDevice;
  final Widget tabletDevice;
  final Widget desktopDevice;

  const RedirectDevice({
    super.key,
    required this.mobileDevice,
    required this.tabletDevice,
    required this.desktopDevice,
  });

  @override
  Widget build(BuildContext context) {
    const mobileWidth = 500;
    const tabletWidth = 1200;
    // const desktopWidth = 1900;

    // 320px — 480px: Mobile devices
    // 481px — 768px: iPads, Tablets
    // 769px — 1024px: Small screens, laptops
    // 1025px — 1200px: Desktops, large screens
    // 1201px and more —  Extra large screens, TV

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileDevice;
        } else if (constraints.maxWidth < tabletWidth) {
          return tabletDevice;
        } else {
          return desktopDevice;
        }
      },
    );
  }
}
