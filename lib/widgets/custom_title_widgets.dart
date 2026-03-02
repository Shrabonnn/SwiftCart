import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTitleWidgets extends StatelessWidget {
  const CustomTitleWidgets({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 35,),),
        const SizedBox(
          height: 10,
        ),
        Text(subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(.6),
          ),
        )
      ],
    );
  }
}
