import 'package:flutter/material.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';

class AppPillChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const AppPillChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.inkColor : AppColors.chipIdleColor,
          borderRadius: .circular(26),
        ),
        padding: .symmetric(horizontal: 18, vertical: 9),
        child: Text(
          label,
          style: AppTextStyles.chip.copyWith(
            color: isSelected ? AppColors.selectedChipTextColor : AppColors.inkColor,
          ),
        ),
      ),
    );
  }
}
