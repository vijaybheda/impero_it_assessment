import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:impero_it_assessment/core/config/env.dart';
import 'package:impero_it_assessment/core/constants/app_strings.dart';
import 'package:impero_it_assessment/core/network/api_client.dart';
import 'package:impero_it_assessment/core/services/local_storage_service.dart';
import 'package:impero_it_assessment/core/theme/theme.dart';
import 'package:impero_it_assessment/core/utils/screen_list.dart';
import 'package:impero_it_assessment/modules/product/provider/product_provider.dart';
import 'package:impero_it_assessment/modules/product/repository/product_repository.dart';
import 'package:impero_it_assessment/modules/product/screen/design_strip_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  AppConfig.setEnvironment(Environment.dev);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetMaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: const Locale('en', 'US'),
        enableLog: true,
        initialBinding: BindingsBuilder(() {
          Get.put(ApiClient());
          Get.put(ProductRepository());
          Get.put(ProductProvider());
        }),
        defaultTransition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 300),
        theme: AppTheme.light.theme,
        darkTheme: AppTheme.dark.theme,
        themeMode: ThemeMode.light,
        home: const DesignStripScreen(),
        // home: const HomeScreen(),
        unknownRoute: ScreenList.unknownRoute,
        getPages: ScreenList.getPages,
        initialRoute: '/',
      ),
    );
  }
}
