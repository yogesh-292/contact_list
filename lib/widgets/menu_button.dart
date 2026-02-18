import 'package:flutter_practice/core/app_imports.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;

  const MenuButton({super.key, required this.title, required this.onTap, this.backgroundColor = Colors.orange});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(14)),
        elevation: 4,
      ),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}
