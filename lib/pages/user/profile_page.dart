import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/pages/add_address/add_address.dart';
import 'package:food_app_panel/pages/user/loginpage.dart';
import 'package:food_app_panel/pages/updateUser/update_user.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false)
          .getRestaurantWonerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(),
        body: Column(
          children: [
            for (int index = 0;
                index < value.restaurantWonerData.length;
                index++) ...[
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                    ),
                    Text(
                      value.restaurantWonerData[index].ownersName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentEmail!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            size: 24,
                          ),
                          Text("Order")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.credit_card_outlined,
                            size: 24,
                          ),
                          Text("payment")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateUser(
                                      data: value.restaurantWonerData[index],
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 24,
                            ),
                            Text("setting")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddAddress()));
                    },
                    child: value.restaurantWonerData[index].address[index]
                                .area !=
                            ""
                        ? ListTile(
                            title: Text(value.restaurantWonerData[index]
                                .address[index].area),
                            subtitle: Text(value.restaurantWonerData[index]
                                .address[index].nearbyLandmark),
                            leading: const Icon(Icons.restaurant),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_outlined),
                          )
                        : const ListTile(
                            title: Text("Address"),
                            leading: Icon(Icons.restaurant),
                            trailing: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(16),
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove("email").then((value) =>
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage())));
                          },
                          child: const Text("Logout")))
                ],
              )
            ]
          ],
        ),
      );
    });
  }
}
