import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_colors.dart';
import '../../core/app_icons.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: .only(left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.inkColor,
          borderRadius: .circular(36),
        ),
        padding: .symmetric(horizontal: 36, vertical: 22),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            _buildBottomNavItemWidget(icon: AppIcons.icHome, index: 0),
            _buildBottomNavItemWidget(icon: AppIcons.icFavorite, index: 1),
            _buildBottomNavItemWidget(icon: AppIcons.icReels, index: 2),
            _buildBottomNavItemWidget(icon: AppIcons.icProfile, index: 3),
          ],
        ),
      ),
      body: navigationShell,
    );
  }

  Widget _buildBottomNavItemWidget({required String icon, required int index}) => GestureDetector(
      onTap: ()=> navigationShell.goBranch(index),
      child: SvgPicture.asset(icon, width: 26, height: 26,));

}