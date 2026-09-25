import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/presentation/home_screen.dart';
import 'package:herbs_and_spices_app/presentation/product_detail_screen.dart';
import 'package:herbs_and_spices_app/presentation/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state) => const WelcomeScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
    GoRoute(
      path: NamedRoutes.product.routeName,
      builder: (ctx, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  product('/product/:id');

  final String routeName;
  const NamedRoutes(this.routeName);
}
