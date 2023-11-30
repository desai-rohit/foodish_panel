import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/additem/add_item.dart';
import 'package:food_app_panel/pages/homepage/home_page.dart';
import 'package:food_app_panel/pages/no_internet/no_internet.dart';
import 'package:food_app_panel/pages/no_internet/provider_internet.dart';
import 'package:food_app_panel/pages/orderPage/order_page.dart';
import 'package:food_app_panel/pages/user/profile_page.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  List<Widget> pages = [
    const HomePage(),
    const AddItem(),
    const OrderPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    Provider.of<ProviderInternet>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderInternet>(builder: (context, value, child) {
      return  Scaffold(
        extendBody: true,
        body: value.isOnline? IndexedStack(
          index: index,
          children: pages,
        ):const NoInternet(),
        // ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).colorScheme.secondaryContainer,
          index: index,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.add_circle, size: 30),
            Icon(Icons.list_alt, size: 30),
            Icon(Icons.account_box, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
            setState(() {
              this.index = index;
            });
          },
        ),
      );
    });
  }
}
