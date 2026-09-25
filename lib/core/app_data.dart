import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/core/asset_res.dart';
import 'package:herbs_and_spices_app/core/models/product.dart';

class AppData {
  static const categories = [
    'Aroma',
    'Herbs',
    'Spices',
    'Seasoning',
  ];

  static const cuisineFilters = [
    'All',
    'Dry',
    'Indian',
    'Continental',
  ];

  static const productForms = [
    'Stick',
    'Powder',
  ];

  static const productSizes = [
    '1gms',
    '50gms',
    '100gms',
  ];

  static const products = [
    Product(
      id: 'chillies',
      name: 'Chillies',
      price: 30,
      image: AssetRes.imgChillies,
      cardTint: AppColors.cardPinkColor,
      description: 'Dried red chillies with bold heat and a smoky finish for everyday cooking.',
      details: [
        '100 % organic product.',
        'No added aroma or color.',
        'Directly imported from Sri Lanka.',
      ],
      forms: productForms,
      sizes: productSizes,
      category: 'Spices',
      cuisines: ['All', 'Dry', 'Indian'],
    ),
    Product(
      id: 'star_anise',
      name: 'Star Anise',
      price: 30,
      image: AssetRes.imgStarAnise,
      cardTint: AppColors.cardPeachColor,
      discountPercent: 15,
      description: 'Star-shaped spice with a warm licorice note, ideal for broths and sweets.',
      details: [
        '100 % organic product.',
        'No added aroma or color.',
        'Directly imported from Sri Lanka.',
      ],
      forms: productForms,
      sizes: productSizes,
      category: 'Spices',
      cuisines: ['All', 'Dry', 'Continental'],
    ),
    Product(
      id: 'cloves',
      name: 'Cloves',
      price: 30,
      image: AssetRes.imgCloves,
      cardTint: AppColors.cardBeigeColor,
      description: 'Aromatic dried flower buds with deep warmth for rice, tea, and marinades.',
      details: [
        '100 % organic product.',
        'No added aroma or color.',
        'Directly imported from Sri Lanka.',
      ],
      forms: productForms,
      sizes: productSizes,
      category: 'Spices',
      cuisines: ['All', 'Dry', 'Indian'],
    ),
    Product(
      id: 'cardamom',
      name: 'Cardamom',
      price: 30,
      image: AssetRes.imgCardamom,
      cardTint: AppColors.cardCreamColor,
      discountPercent: 15,
      description: 'Green pods with a floral, citrus aroma that brightens desserts and chai.',
      details: [
        '100 % organic product.',
        'No added aroma or color.',
        'Directly imported from Sri Lanka.',
      ],
      forms: productForms,
      sizes: productSizes,
      category: 'Spices',
      cuisines: ['All', 'Dry', 'Indian', 'Continental'],
    ),
    Product(
      id: 'cinnamon',
      name: 'Cinnamon',
      price: 30,
      image: AssetRes.imgCinnamon,
      cardTint: AppColors.cardSageColor,
      description: 'Culinary spice of dried fruit from SriLanka. It is obtained from the inner bark of several tree species',
      details: [
        '100 % organic product.',
        'No added aroma or color.',
        'Directly imported from Sri Lanka.',
      ],
      forms: productForms,
      sizes: productSizes,
      category: 'Spices',
      cuisines: ['All', 'Dry', 'Indian', 'Continental'],
    ),
  ];

  static Product? productById(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  static List<Product> filteredProducts({
    required String category,
    required String cuisine,
  }) {
    return products.where((product) {
      final matchesCategory = product.category == category;
      final matchesCuisine = cuisine == 'All' || product.cuisines.contains(cuisine);
      return matchesCategory && matchesCuisine;
    }).toList();
  }
}
