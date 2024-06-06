import 'package:flutter/cupertino.dart';
import 'package:shoesly/styles/app_colors.dart';

class AppStyles {
  static const titleStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: AppColors.primaryColor,
  );

  static const subTitleStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.secondaryColor,
  );

  static const subTitleStyleAlt = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.primaryColor,
  );

  static const infoStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.primaryColor,
  );

  static const regularStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.primaryColor,
  );

  static const regularStyleAlt = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.appWhite,
  );

  static const lightStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: AppColors.primaryColor,
  );

  static const lightStyleAlt = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: AppColors.appWhite,
  );

  static const extraLightStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w200,
    fontSize: 14,
    color: AppColors.appDarkGrey,
    height: 2,
  );

  static const thinStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w100,
    fontSize: 12,
    color: AppColors.primaryColor,
  );

  static const bodyStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w100,
    fontSize: 10,
    color: AppColors.secondaryColor,
  );
}
