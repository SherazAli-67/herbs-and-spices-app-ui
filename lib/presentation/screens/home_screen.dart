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

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = AppData.categories[2];
  String _selectedCuisine = AppData.cuisineFilters.first;

  List<Product> get _products => AppData.filteredProducts(category: _selectedCategory, cuisine: _selectedCuisine,);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
            child: Row(
              spacing: 22,
              children: [
                Container(
              height: .infinity,
              decoration: BoxDecoration(
               /* gradient: LinearGradient(colors: [
                  AppColors.offWhiteColor,
                  AppColors.gradientColor2,
                  AppColors.gradientColor2,
                  AppColors.offWhiteColor
                ],
                    stops: [
                      0,
                      0.27,
                      0.67,
                      1
                    ]
                )*/
              ),
              child: Column(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  for (final category in AppData.categories)
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category),
                      behavior: .opaque,
                      child: Padding(
                        padding: .symmetric(horizontal: 13.24),
                        child: Stack(
                          alignment: .topStart,
                          children: [
                            if (_selectedCategory == category)
                              Align(
                                alignment: .centerLeft,
                                child: SizedBox(
                                  width: 4,
                                  height: 48,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      // color: AppColors.inkColor,
                                      // borderRadius: .horizontal(right: .circular(99)),
                                    ),
                                  ),
                                ),
                              ),
                            RotatedBox(
                              quarterTurns: 3,
                              //category,  _selectedCategory == category  ? AppTextStyles.categoryActive : AppTextStyles.categoryIdle,
                              child:  const SizedBox()
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
                Expanded(
                  child: Padding(padding: .only(top: 17), child: Column(
                    spacing: 22,
                    children: [
                      // _buildCuisineChips(),
                      Expanded(child: _buildProductGrid()),
                    ],
                  ),),
                )
              ],
        ))
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: .none,
        children: [
          Positioned.fill(
            //icHeaderWave, fit: fill
            child: const SizedBox()
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: .only(left: 26, right: 12, bottom: 26),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 28,
                children: [
                  Row(
                    children: [
                      //icDrawer
                      const Spacer(),
                      Row(
                        spacing: 13,
                        children: [
                          //icSearch
                          //icCart
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
                            //discover, discoverLabel,
                            //yourTaste, discoverHero
                          ],
                        ),
                      ),
                      Stack(
                        alignment: .center,
                        children: [
                          //icBadgeOff
                          Transform.rotate(
                            angle: -0.33,

                            //tenPercentOff, badgeOff
                            child: const SizedBox()
                          ),
                        ],
                      )
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
      child: Padding(
        padding: const .only(right: 20.0),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 14,
          children: [
            Expanded(
              child: Column(
                spacing: 17.66,
                children: [
                  for (final product in left) _buildProductCard(product),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 17.66,
                children: [
                  const SizedBox(height: 36),
                  for (final product in right) _buildProductCard(product),
                ],
              ),
            ),
          ],
        ),
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
        /*  boxShadow: [
            BoxShadow(
              offset: Offset(-8.83, 8.83),
              blurRadius: 17.68,
              spreadRadius: 0,
              color: AppColors.shadowColor.withValues(alpha: 0.5)
            ),
            BoxShadow(
                offset: Offset(8.83, 8.83),
                blurRadius: 17.66,
                spreadRadius: 0,
                color: AppColors.shadowColor.withValues(alpha: 0.5)
            )
          ]*/
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                   /* borderRadius: .only(topRight: .circular(11), topLeft: .circular(11)),
                    color: product.cardTint*/
                  ),
                  alignment: .center,
                  //product.image, fit: cover
                  child: const SizedBox()
                ),
                if(product.discountPercent != null)
                  Positioned(
                      right: 0,
                      top: 10,
                      //icDiscountRibbon
                      child: const SizedBox()
                  )
              ],
            ),
            Padding(padding: .symmetric(horizontal: 8.83, vertical: 17), child: Column(
              crossAxisAlignment: .start,
              children: [
                //product.name, style: cardName
                Row(
                  children: [
                    //\$${product.price}/g, style: cardPrice
                    Expanded(child: const SizedBox()),
                    Container(
                      decoration: BoxDecoration(
                        // shape: .circle,
                        // color: AppColors.inkColor
                      ),
                      padding: .all(9),
                      //icAdd
                      child: const SizedBox()
                    )
                  ],
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
