import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_icons.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';
import 'package:herbs_and_spices_app/core/asset_res.dart';
import 'package:herbs_and_spices_app/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                AssetRes.imgTexture,
                repeat: .repeat,
                alignment: .topLeft,
                fit: .none,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const SizedBox(height: 28),
                  _buildLogo(),
                  Expanded(child: _buildHeroImage()),
                  _buildHeadline(),
                  const SizedBox(height: 16),
                  Text(StringConst.onboardingBody, style: AppTextStyles.bodyLarge,),
                  const SizedBox(height: 36),
                  _buildBottomBar(context),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SvgPicture.asset(
        AppIcons.icWelcomeLogo,
        width: 317,
        height: 97,
      ),
    );
  }

  Widget _buildHeroImage() {
    return Center(
      child: Padding(
        padding: .symmetric(vertical: 12),
        child: Image.asset(
          AssetRes.welcomeImg,
          width: 319,
          fit: .contain,
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.onboardingHeadline,
        children: [
          TextSpan(text: StringConst.onboardingHeadlinePrefix),
          TextSpan(text: StringConst.onboardingHeadlineBlast, style: AppTextStyles.onboardingHighlight,),
          TextSpan(text: StringConst.onboardingHeadlineOf),
          TextSpan(text: StringConst.onboardingHeadlineFeelGood, style: AppTextStyles.onboardingHighlight,),
          TextSpan(text: StringConst.onboardingHeadlineSuffix),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.icOnboardingDots,
          width: 71,
          height: 15,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => context.go(NamedRoutes.home.routeName),
          child: SvgPicture.asset(
            AppIcons.icOnboardingNext,
            width: 87,
            height: 87,
          ),
        ),
      ],
    );
  }
}
