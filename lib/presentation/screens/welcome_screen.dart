import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_icons.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';
import 'package:herbs_and_spices_app/core/asset_res.dart';
import 'package:herbs_and_spices_app/routing/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _nextPressController;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _heroFade;
  late final Animation<double> _heroScale;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _bottomFade;
  late final Animation<double> _nextScale;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _nextPressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _logoFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0, 0.35, curve: Curves.easeOutCubic));
    _logoSlide = Tween(begin: const Offset(0, -0.12), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0, 0.35, curve: Curves.easeOutCubic)),
    );
    _heroFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.55, curve: Curves.easeOutCubic));
    _heroScale = Tween(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.55, curve: Curves.easeOutCubic)),
    );
    _textFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.75, curve: Curves.easeOutCubic));
    _textSlide = Tween(begin: const Offset(0, 0.18), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.75, curve: Curves.easeOutCubic)),
    );
    _bottomFade = CurvedAnimation(parent: _entranceController, curve: const Interval(0.65, 1, curve: Curves.easeOutCubic));
    _nextScale = Tween(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _nextPressController, curve: Curves.easeOutCubic),
    );
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nextPressController.dispose();
    super.dispose();
  }

  Future<void> _onNextTap() async {
    await _nextPressController.forward();
    await _nextPressController.reverse();
    if (!mounted) return;
    context.go(NamedRoutes.home.routeName);
  }

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
                  _buildTextBlock(),
                  const SizedBox(height: 36),
                  _buildBottomBar(),
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
    return FadeTransition(
      opacity: _logoFade,
      child: SlideTransition(
        position: _logoSlide,
        child: Center(
          child: SvgPicture.asset(AppIcons.icWelcomeLogo, width: 317, height: 97,),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return FadeTransition(
      opacity: _heroFade,
      child: ScaleTransition(
        scale: _heroScale,
        child: Center(
          child: Padding(
            padding: .symmetric(vertical: 12),
            child: Image.asset(AssetRes.welcomeImg, width: 319, fit: .contain,),
          ),
        ),
      ),
    );
  }

  Widget _buildTextBlock() {
    return FadeTransition(
      opacity: _textFade,
      child: SlideTransition(
        position: _textSlide,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildHeadline(),
            const SizedBox(height: 16),
            Text(StringConst.onboardingBody, style: AppTextStyles.bodyLarge,),
          ],
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

  Widget _buildBottomBar() {
    return FadeTransition(
      opacity: _bottomFade,
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.icOnboardingDots, width: 71, height: 15,),
          const Spacer(),
          GestureDetector(
            onTap: _onNextTap,
            child: ScaleTransition(
              scale: _nextScale,
              child: SvgPicture.asset(AppIcons.icOnboardingNext, width: 87, height: 87,),
            ),
          ),
        ],
      ),
    );
  }
}
