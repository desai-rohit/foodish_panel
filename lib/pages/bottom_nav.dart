import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/add_item.dart';
import 'package:food_app_panel/pages/home_page.dart';
import 'package:food_app_panel/pages/order_page.dart';
import 'package:food_app_panel/pages/profile_page.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:
          //Expanded(child: pages.elementAt(index)

          IndexedStack(
        index: index,
        children: pages,
      ),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.red,
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
  }
}
