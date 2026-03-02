import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onTap, this.backgroundColor, this.titleColor, this.isLoading});

  final String title;
  final Color ?backgroundColor;
  final Color ?titleColor;
  final VoidCallback onTap;
  final bool?isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
            color:backgroundColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child:Center(
          child: isLoading ==true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                color: titleColor ?? Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  color: titleColor ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          )
              :Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$title',style: TextStyle(
                  color: titleColor ?? Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),),
            ],
          ),
        )
      ),
    );
  }
}
