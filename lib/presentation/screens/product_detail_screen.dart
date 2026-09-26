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

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late PageController _pageController;
  late int _pageIndex;
  late String _selectedForm;
  late String _selectedSize;

  Product get _product =>
      AppData.productById(AppData.products[_pageIndex].id) ?? AppData.products[_pageIndex];

  @override
  void initState() {
    super.initState();
    final initialIndex = AppData.products.indexWhere((p) => p.id == widget.productId);
    _pageIndex = initialIndex >= 0 ? initialIndex : 0;
    _pageController = PageController(initialPage: _pageIndex);
    _selectedForm = AppData.products[_pageIndex].forms.first;
    _selectedSize = AppData.products[_pageIndex].sizes.first;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() {
        _pageIndex = index;
        _selectedForm = AppData.products[index].forms.first;
        _selectedSize = AppData.products[index].sizes.first;
      });

  @override
  Widget build(BuildContext context) {
    final product = _product;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: .fromLTRB(22, 8, 22, 0),
                  child: Align(
                    alignment: .centerLeft,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(AppIcons.icBack, width: 26, height: 26,),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: .only(bottom: 120),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 16,
                    children: [
                      _buildCarousel(),
                      _buildPagination(),
                      Padding(
                        padding: .symmetric(horizontal: 22),
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 20,
                          children: [
                            _buildTitleRow(product),
                            _buildOptions(product),
                            _buildDetails(product),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 26,
            right: 26,
            bottom: MediaQuery.paddingOf(context).bottom + 16,
            child: _buildCheckoutButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Stack(
        clipBehavior: .none,
        alignment: .center,
        children: [
          Positioned(
            left: -250,
            child: SvgPicture.asset(AppIcons.icDetailBlobLeft, width: 300, height: 310,),
          ),
          Positioned(
            right: -250,
            child: SvgPicture.asset(AppIcons.icDetailBlobRight, width: 300, height: 310,),
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: AppData.products.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => _buildCarouselPage(AppData.products[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselPage(Product product) {
    return Stack(
      alignment: .center,
      children: [
        SvgPicture.asset(AppIcons.icDetailBlob, height: 300,),
        Positioned(
          left: 0,
          bottom: 0,
          child: Hero(
            tag: product.id,
            child: Image.asset(
              product.image,
              height: 290,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: .center,
      spacing: 10,
      children: [
        for (var i = 0; i < AppData.products.length; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: i == _pageIndex ? 27 : 11,
            height: 11,
            decoration: BoxDecoration(
              color: i == _pageIndex ? AppColors.primaryGreenColor : AppColors.mintColor,
              borderRadius: .circular(11),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleRow(Product product) {
    return Row(
      spacing: 29,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 10,
            children: [
              Text(product.name, style: AppTextStyles.productTitle,),
              Text(product.description, style: AppTextStyles.body,),
            ],
          ),
        ),

        Text(StringConst.priceLabel(product.price), style: AppTextStyles.productPrice,),
      ],
    );
  }

  Widget _buildOptions(Product product) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: .horizontal,
            child: Row(
              spacing: 17,
              children: [
                for (final form in product.forms)
                  AppPillChip(
                    label: form,
                    isSelected: _selectedForm == form,
                    onTap: () => setState(() => _selectedForm = form),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildQuantitySelector(product),
      ],
    );
  }

  Widget _buildQuantitySelector(Product product) {
    return PopupMenuButton<String>(
      onSelected: (size) => setState(() => _selectedSize = size),
      itemBuilder: (context) => [
        for (final size in product.sizes)
          PopupMenuItem(value: size, child: Text(size, style: AppTextStyles.chip.copyWith(color: AppColors.inkColor),)),
      ],
      child: Container(
        decoration: BoxDecoration(
          border: .all(color: AppColors.inkColor, width: 1),
          borderRadius: .circular(26),
        ),
        padding: .symmetric(horizontal: 17, vertical: 9),
        child: Row(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            Text(_selectedSize, style: AppTextStyles.chip.copyWith(color: AppColors.inkColor),),
            SvgPicture.asset(AppIcons.icChevronDown, width: 17, height: 17,),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(Product product) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            Text(StringConst.details, style: AppTextStyles.detailsLabel,),
            Column(
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                for (final detail in product.details)
                  Text(detail, style: AppTextStyles.detailsItem,),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
        Positioned(
          right: 0,
          bottom: 8,
          child: Opacity(
            opacity: 0.45,
            child: SvgPicture.asset(
              AppIcons.icCinnamonIllustration,
              width: 74,
              height: 56,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.inkColor,
        borderRadius: .circular(36),
      ),
      padding: .symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.icCheckoutBag, width: 44, height: 44,),
          const SizedBox(width: 14),
          Row(
            spacing: 2,
            children: [
              for (var i = 0; i < 3; i++)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.whiteColor.withValues(alpha: 0.35 + (i * 0.2)),
                ),
            ],
          ),
          const Spacer(),
          Text(StringConst.checkOut, style: AppTextStyles.checkout,),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}
