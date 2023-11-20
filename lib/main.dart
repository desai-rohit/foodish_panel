import 'package:flutter/material.dart';
import 'package:food_app_panel/config/my_theme.dart';
import 'package:food_app_panel/pages/add_address/addaddress_provider.dart';
import 'package:food_app_panel/pages/additem/additem_provider.dart';
import 'package:food_app_panel/pages/homepage/homepage_provider.dart';
import 'package:food_app_panel/pages/orderPage/orderpage_provider.dart';
import 'package:food_app_panel/pages/spalshscreen/spalsh_screen.dart';
import 'package:food_app_panel/pages/updateProduct/updateProducts_provider.dart';
import 'package:food_app_panel/pages/updateUser/updateuser_provider.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';

import 'package:provider/provider.dart';

final bucketGlobal = PageStorageBucket();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AddAddressProvider()),
    ChangeNotifierProvider(create: (_) => AddItemProvider()),
    ChangeNotifierProvider(create: (_) => HomePageProvider()),
    ChangeNotifierProvider(create: (_) => OrderPageProvider()),
    ChangeNotifierProvider(create: (_) => UpdateProductsProvider()),
    ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PageStorage(
        bucket: bucketGlobal,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: ThemeMode.system,
            home: const SpalshScreen()));
  }
}
