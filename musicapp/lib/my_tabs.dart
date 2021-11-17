// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;

  const AppTabs({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 50,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                offset: const Offset(0, 0))
          ]),
    );
  }
}
