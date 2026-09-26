import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:herbs_and_spices_app/presentation/screens/home_screen.dart';
import 'package:herbs_and_spices_app/presentation/screens/product_detail_screen.dart';
import '../presentation/screens/main_menu_page.dart';
import '../presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (ctx, state) => const WelcomeScreen()),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.home.routeName, builder: (_, state) => HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.favorite.routeName, builder: (_, state) => Center(child: Text("Favorites"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.reels.routeName, builder: (_, state) => Center(child: Text("Reels"),)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: NamedRoutes.profile.routeName, builder: (_, state) => Center(child: Text("Profile"),)),
        ]),
      ],
      builder: (ctx, state, navigationShell) => MainMenuPage(navigationShell: navigationShell),
    ),
    GoRoute(
      path: NamedRoutes.product.routeName,
      builder: (ctx, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  favorite('/favorite'),
  reels('/reels'),
  profile('/profile'),
  product('/product/:id');

  final String routeName;
  const NamedRoutes(this.routeName);
}
