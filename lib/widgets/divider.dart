import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final Color? color;

  const AppDivider({super.key, required this.height, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: Colors.grey.shade300,
    );
  }
}
