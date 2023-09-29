import 'package:awii/core/constants/exports.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    String route = routeSettings.name ?? '';
    switch (route) {
      case RouteNames.loadingScreen:
        return NoAnimationMaterialPageRoute(
            builder: (_) => const LoadingPage());
      case RouteNames.loginScreen:
        return NoAnimationMaterialPageRoute(
            builder: (_) => const LoginScreen());
      case RouteNames.invoiceScreen:
        return NoAnimationMaterialPageRoute(
            builder: (_) => const InvoiceScreen());
      case RouteNames.introScreen:
        return NoAnimationMaterialPageRoute(
            builder: (_) => const IntroScreen());
      default:
        return null;
    }
  }
}
