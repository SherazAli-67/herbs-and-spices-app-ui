import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/app_data.dart';
import 'package:herbs_and_spices_app/core/app_icons.dart';
import 'package:herbs_and_spices_app/core/app_textstyles.dart';
import 'package:herbs_and_spices_app/core/asset_res.dart';
import 'package:herbs_and_spices_app/core/models/product.dart';
import 'package:herbs_and_spices_app/presentation/widgets/app_pill_chip.dart';
import 'package:herbs_and_spices_app/routing/router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = AppData.categories[2];
  String _selectedCuisine = AppData.cuisineFilters.first;

  List<Product> get _products => AppData.filteredProducts(
        category: _selectedCategory,
        cuisine: _selectedCuisine,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildBody()),
            ],
          ),
          Positioned(
            left: 26,
            right: 26,
            bottom: MediaQuery.paddingOf(context).bottom + 12,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppIcons.icHeaderWave,
              fit: .fill,
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.18,
              child: Image.asset(
                AssetRes.imgTexture,
                repeat: .repeat,
                alignment: .topLeft,
                fit: .none,
                color: AppColors.whiteColor,
                colorBlendMode: .softLight,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: .symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const SizedBox(height: 8),
                  _buildTopNav(),
                  const SizedBox(height: 28),
                  Row(
                    crossAxisAlignment: .start,
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
        ],
      ),
    );
  }

  Widget _buildTopNav() {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.icDrawer, width: 26, height: 26,),
        const Spacer(),
        Row(
          spacing: 13,
          children: [
            SvgPicture.asset(AppIcons.icSearch, width: 29, height: 29,),
            SvgPicture.asset(AppIcons.icCart, width: 26, height: 26,),
          ],
        ),
      ],
    );
  }

  Widget _buildOffBadge() {
    return Transform.rotate(
      angle: -0.16,
      child: SizedBox(
        width: 89,
        height: 93,
        child: Stack(
          alignment: .center,
          children: [
            SvgPicture.asset(AppIcons.icBadgeOff, width: 78, height: 82,),
            Transform.rotate(
              angle: -0.33,
              child: Text(StringConst.tenPercentOff, style: AppTextStyles.badgeOff,),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      crossAxisAlignment: .start,
      children: [
        _buildCategoryRail(),
        Expanded(
          child: Padding(
            padding: .only(top: 8, right: 16),
            child: Column(
              children: [
                _buildCuisineChips(),
                const SizedBox(height: 18),
                Expanded(child: _buildProductGrid()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRail() {
    return SizedBox(
      width: 54,
      child: Padding(
        padding: .only(top: 40, bottom: 120),
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: [
            for (final category in AppData.categories)
              GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                behavior: .opaque,
                child: SizedBox(
                  height: 72,
                  child: Stack(
                    alignment: .center,
                    children: [
                      if (_selectedCategory == category)
                        Align(
                          alignment: .centerLeft,
                          child: SizedBox(
                            width: 4,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.inkColor,
                                borderRadius: .horizontal(right: .circular(2)),
                              ),
                            ),
                          ),
                        ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          category,
                          style: _selectedCategory == category
                              ? AppTextStyles.categoryActive
                              : AppTextStyles.categoryIdle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
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
            onTap: () => setState(() => _selectedCuisine = cuisine),
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

    return SingleChildScrollView(
      padding: .only(bottom: 110),
      child: Row(
        crossAxisAlignment: .start,
        spacing: 14,
        children: [
          Expanded(
            child: Column(
              spacing: 18,
              children: [
                for (final product in left) _buildProductCard(product),
              ],
            ),
          ),
          Expanded(
            child: Column(
              spacing: 18,
              children: [
                const SizedBox(height: 36),
                for (final product in right) _buildProductCard(product),
              ],
            ),
          ),
        ],
      ),
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
            ClipRRect(
              borderRadius: const .vertical(top: .circular(11)),
              child: SizedBox(
                height: 145,
                width: double.infinity,
                child: ColoredBox(
                  color: product.cardTint,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          product.image,
                          height: 95,
                          fit: .contain,
                        ),
                      ),
                      if (product.discountPercent != null)
                        Positioned(
                          top: 12,
                          right: 0,
                          child: SizedBox(
                            width: 72,
                            height: 22,
                            child: Stack(
                              alignment: .center,
                              children: [
                                SvgPicture.asset(
                                  AppIcons.icDiscountRibbon,
                                  width: 72,
                                  height: 22,
                                  fit: .fill,
                                ),
                                Text(
                                  StringConst.percentOff(product.discountPercent!),
                                  style: AppTextStyles.discountRibbon,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: .fromLTRB(10, 10, 10, 12),
              child: Row(
                crossAxisAlignment: .end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 6,
                      children: [
                        Text(product.name, style: AppTextStyles.cardName,),
                        Text(StringConst.pricePerGram(product.price), style: AppTextStyles.cardPrice,),
                      ],
                    ),
                  ),
                  Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      color: AppColors.inkColor,
                      shape: .circle,
                    ),
                    alignment: .center,
                    child: SvgPicture.asset(AppIcons.icAdd, width: 14, height: 14,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 73,
      decoration: BoxDecoration(
        color: AppColors.inkColor,
        borderRadius: .circular(36),
      ),
      padding: .symmetric(horizontal: 36),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          SvgPicture.asset(AppIcons.icHome, width: 26, height: 26,),
          SvgPicture.asset(AppIcons.icFavorite, width: 26, height: 26,),
          SvgPicture.asset(AppIcons.icReels, width: 26, height: 26,),
          SvgPicture.asset(AppIcons.icProfile, width: 26, height: 26,),
        ],
      ),
    );
  }
}
