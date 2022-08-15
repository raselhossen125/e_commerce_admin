// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:e_commerce_admin/pages/category_page.dart';
import 'package:e_commerce_admin/pages/launcher_page.dart';
import 'package:e_commerce_admin/pages/logIn_page.dart';
import 'package:e_commerce_admin/pages/new_products_page.dart';
import 'package:e_commerce_admin/pages/orders_page.dart';
import 'package:e_commerce_admin/pages/product_details_page.dart';
import 'package:e_commerce_admin/pages/products_page.dart';
import 'package:e_commerce_admin/pages/report_page.dart';
import 'package:e_commerce_admin/pages/settings_page.dart';
import 'package:e_commerce_admin/pages/users_page.dart';
import 'package:e_commerce_admin/provider/order_provider.dart';
import 'package:e_commerce_admin/provider/product_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/dashbord_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff4FAA89),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: Color.fromARGB(255, 24, 1, 105),
      100: Color.fromARGB(255, 255, 88, 88),
      200: Color.fromARGB(255, 255, 88, 88),
      300: Color.fromARGB(255, 255, 88, 88),
      400: Color.fromARGB(255, 255, 88, 88),
      500: Color.fromARGB(255, 255, 88, 88),
      600: Color.fromARGB(255, 255, 88, 88),
      700: Color.fromARGB(255, 255, 88, 88),
      800: Color.fromARGB(255, 255, 88, 88),
      900: Color.fromARGB(255, 252, 70, 70),
    };
    MaterialColor pokeballRed = MaterialColor(0xff4FAA89, pokeballRedSwatch);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: pokeballRed,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LogInPage.routeName: (_) => LogInPage(),
        DashbordPage.routeName: (_) => DashbordPage(),
        CategoryPage.routeName: (_) => CategoryPage(),
        OrdersPage.routeName: (_) => OrdersPage(),
        ProductsPage.routeName: (_) => ProductsPage(),
        ReportPage.routeName: (_) => ReportPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
        UsersPage.routeName: (_) => UsersPage(),
        NewProductsPage.routeName: (_) => NewProductsPage(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
      },
    );
  }
}
