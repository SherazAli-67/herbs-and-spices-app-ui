import 'package:flutter/material.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';

class AppTextStyles {
  static const discoverLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 31,
    fontWeight: .w400,
    color: AppColors.whiteColor,
    height: 1,
  );

  static const discoverHero = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 54,
    fontWeight: .w500,
    color: AppColors.whiteColor,
    height: 1,
  );

  static const productTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 35,
    fontWeight: .w400,
    color: AppColors.inkColor,
    height: 1,
  );

  static const productPrice = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 35,
    fontWeight: .w700,
    color: AppColors.inkColor,
    height: 1,
  );

  static const cardPrice = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 18,
    fontWeight: .w700,
    color: AppColors.inkColor,
    height: 1,
  );

  static const cardName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 13,
    fontWeight: .w400,
    color: AppColors.mutedColor,
    height: 1.5,
  );

  static const body = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 15,
    fontWeight: .w400,
    color: AppColors.bodyGreyColor,
    height: 1.5,
  );

  static const bodyLarge = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 17,
    fontWeight: .w400,
    color: AppColors.bodyGreyColor,
    height: 1.5,
  );

  static const detailsLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 17,
    fontWeight: .w700,
    color: AppColors.mutedColor,
    height: 1,
  );

  static const detailsItem = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 17,
    fontWeight: .w400,
    color: AppColors.mutedColor,
    height: 1,
  );

  static const chip = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 17,
    fontWeight: .w400,
    height: 1.5,
  );

  static const categoryActive = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 18,
    fontWeight: .w500,
    color: AppColors.inkColor,
    height: 1.5,
  );

  static const categoryIdle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 18,
    fontWeight: .w400,
    color: AppColors.mutedColor,
    height: 1.5,
  );

  static const onboardingHeadline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 32,
    fontWeight: .w400,
    color: AppColors.inkColor,
    height: 1.5,
  );

  static const onboardingHighlight = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 32,
    fontWeight: .w800,
    color: AppColors.primaryGreenColor,
    height: 1.5,
  );

  static const checkout = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 17,
    fontWeight: .w700,
    color: AppColors.whiteColor,
    height: 1,
  );

  static const discountRibbon = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 11,
    fontWeight: .w800,
    color: AppColors.whiteColor,
    height: 1,
  );

  static const badgeOff = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontSize: 14,
    fontWeight: .w700,
    color: AppColors.inkColor,
    height: 1,
    letterSpacing: -0.7,
  );
}
