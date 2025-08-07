import 'package:get/get.dart';
import 'package:impero_it_assessment/modules/error/error_404_screen.dart';
import 'package:impero_it_assessment/modules/product/screen/design_strip_screen.dart';
import 'package:impero_it_assessment/modules/product/screen/home_screen.dart';

class ScreenList {
  static GetPage<dynamic> unknownRoute = GetPage(
    name: Error404Screen.routeName,
    page: () => Error404Screen(),
  );
  static List<GetPage<dynamic>> getPages = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/design-strip', page: () => const DesignStripScreen()),
  ];
}
