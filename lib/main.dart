import 'package:flutter/material.dart';
import 'package:food_app_panel/config/my_theme.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/pages/loginpage.dart';
import 'package:food_app_panel/provider/App_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final bucketGlobal = PageStorageBucket();

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    getValidationdata();

    super.initState();
  }

  Future getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");
    Provider.of<AppProvider>(context, listen: false).getemail(obtainedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucketGlobal,
      child: Consumer<AppProvider>(builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home:
              value.finalEmail == null ? const LoginPage() : const BottomNav(),
        );
      }),
    );
  }
}
