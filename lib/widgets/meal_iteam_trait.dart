import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MealIteamTrait extends StatelessWidget {
  const MealIteamTrait({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
