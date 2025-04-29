import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return desktopBody;   // Màn hình lớn (PC)
        } else if (constraints.maxWidth > 600) {
          return tabletBody;    // Máy tính bảng
        } else {
          return mobileBody;    // Điện thoại
        }
      },
    );
  }
}
