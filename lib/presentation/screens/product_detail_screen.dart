import 'package:flutter/material.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteColor,
      body: Center(child: Text(productId, style: AppTextStyles.productTitle,),),
    );
  }
}
