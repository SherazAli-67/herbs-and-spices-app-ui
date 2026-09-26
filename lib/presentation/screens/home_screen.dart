import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_data.dart';
import 'package:herbs_and_spices_app/core/app_icons.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';
import 'package:herbs_and_spices_app/core/models/product.dart';
import 'package:herbs_and_spices_app/presentation/widgets/app_pill_chip.dart';
import 'package:herbs_and_spices_app/routing/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _selectedCategory = AppData.categories[2];
  String _selectedCuisine = AppData.cuisineFilters.first;
  late final AnimationController _headerController;
  late final AnimationController _badgeController;
  late final AnimationController _gridController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  List<Product> get _products => AppData.filteredProducts(
        category: _selectedCategory,
        cuisine: _selectedCuisine,
      );

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _badgeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));
    _gridController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _headerFade = CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic);
    _headerSlide = Tween(begin: const Offset(0, -0.08), end: Offset.zero).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );
    _headerController.forward();
    _badgeController.repeat(reverse: true);
    _gridController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _badgeController.dispose();
    _gridController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory == category) return;
    setState(() => _selectedCategory = category);
    _gridController
      ..reset()
      ..forward();
  }

  void _onCuisineSelected(String cuisine) {
    if (_selectedCuisine == cuisine) return;
    setState(() => _selectedCuisine = cuisine);
    _gridController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Row(
            spacing: 22,
            children: [
              _buildCategoryRail(),
              Expanded(
                child: Padding(
                  padding: .only(top: 17),
                  child: Column(
                    spacing: 22,
                    children: [
                      _buildCuisineChips(),
                      Expanded(child: _buildProductGrid()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned.fill(child: SvgPicture.asset(AppIcons.icHeaderWave, fit: .fill,)),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: .only(left: 26, right: 12, bottom: 26),
              child: FadeTransition(
                opacity: _headerFade,
                child: SlideTransition(
                  position: _headerSlide,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 28,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.icDrawer,),
                          const Spacer(),
                          Row(
                            spacing: 13,
                            children: [
                              SvgPicture.asset(AppIcons.icSearch),
                              SvgPicture.asset(AppIcons.icCart),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              spacing: 4,
                              children: [
                                Text(StringConst.discover, style: AppTextStyles.discoverLabel,),
                                Text(StringConst.yourTaste, style: AppTextStyles.discoverHero,),
                              ],
                            ),
                          ),
                          _buildOffBadge(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOffBadge() {
    return AnimatedBuilder(
      animation: _badgeController,
      builder: (context, child) {
        final wobble = math.sin(_badgeController.value * math.pi * 2) * 0.035;
        return Transform.rotate(angle: -0.16 + wobble, child: child);
      },
      child: Stack(
        alignment: .center,
        children: [
          SvgPicture.asset(AppIcons.icBadgeOff),
          Transform.rotate(
            angle: -0.33,
            child: Text(StringConst.tenPercentOff, style: AppTextStyles.badgeOff,),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRail() {
    return Container(
      height: .infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.offWhiteColor,
            AppColors.gradientColor2,
            AppColors.gradientColor2,
            AppColors.offWhiteColor,
          ],
          stops: const [0, 0.27, 0.67, 1],
        ),
      ),
      child: Column(
        mainAxisAlignment: .spaceEvenly,
        children: [
          for (final category in AppData.categories)
            GestureDetector(
              onTap: () => _onCategorySelected(category),
              behavior: .opaque,
              child: Padding(
                padding: .symmetric(horizontal: 13.24),
                child: Stack(
                  alignment: .centerLeft,
                  children: [
                    AnimatedOpacity(
                      opacity: _selectedCategory == category ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        width: 4,
                        height: _selectedCategory == category ? 48 : 0,
                        decoration: BoxDecoration(
                          color: AppColors.inkColor,
                          borderRadius: .circular(99),
                        ),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: _selectedCategory == category
                            ? AppTextStyles.categoryActive
                            : AppTextStyles.categoryIdle,
                        child: Text(category),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCuisineChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: AppData.cuisineFilters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final cuisine = AppData.cuisineFilters[index];
          return AppPillChip(
            label: cuisine,
            isSelected: _selectedCuisine == cuisine,
            onTap: () => _onCuisineSelected(cuisine),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = _products;
    final left = <Product>[];
    final right = <Product>[];
    for (var i = 0; i < products.length; i++) {
      if (i.isEven) {
        left.add(products[i]);
      } else {
        right.add(products[i]);
      }
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.06), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: KeyedSubtree(
        key: ValueKey('$_selectedCategory|$_selectedCuisine'),
        child: SingleChildScrollView(
          child: Padding(
            padding: const .only(right: 20),
            child: Row(
              crossAxisAlignment: .start,
              spacing: 14,
              children: [
                Expanded(
                  child: Column(
                    spacing: 17.66,
                    children: [
                      for (var i = 0; i < left.length; i++)
                        _buildStaggeredCard(product: left[i], index: i * 2),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 17.66,
                    children: [
                      const SizedBox(height: 36),
                      for (var i = 0; i < right.length; i++)
                        _buildStaggeredCard(product: right[i], index: i * 2 + 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredCard({required Product product, required int index}) {
    final start = (0.08 * index).clamp(0.0, 0.55);
    final end = (start + 0.45).clamp(0.0, 1.0);
    return AnimatedBuilder(
      animation: _gridController,
      builder: (context, child) {
        final progress = ((_gridController.value - start) / (end - start)).clamp(0.0, 1.0);
        final t = Curves.easeOutCubic.transform(progress);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - t)),
            child: child,
          ),
        );
      },
      child: _buildProductCard(product),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.product.routeName.replaceFirst(':id', product.id)),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: .circular(11),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: product.cardTint,
                    borderRadius: .only(topLeft: .circular(11), topRight: .circular(11)),
                  ),
                  alignment: .center,
                  child: Hero(
                    tag: product.id,
                    child: Image.asset(product.image, fit: .cover,),
                  ),
                ),
                if (product.discountPercent != null)
                  Positioned(
                    right: 0,
                    top: 10,
                    child: SvgPicture.asset(AppIcons.icDiscountRibbon),
                  ),
              ],
            ),
            Padding(
              padding: .symmetric(horizontal: 8.83, vertical: 17),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(product.name, style: AppTextStyles.cardName,),
                  Row(
                    children: [
                      Expanded(child: Text('\$${product.price}/g', style: AppTextStyles.cardPrice,)),
                      Container(
                        decoration: BoxDecoration(
                          shape: .circle,
                          color: AppColors.inkColor,
                        ),
                        padding: .all(9),
                        child: SvgPicture.asset(AppIcons.icAdd),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
