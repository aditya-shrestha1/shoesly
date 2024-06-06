import 'package:flutter/material.dart';
import 'package:shoesly/styles/app_colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}

class AppLinearProgressIndicator extends StatelessWidget {
  const AppLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LinearProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
