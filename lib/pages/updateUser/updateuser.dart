import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/updateUser/updateuser_provider.dart';
import 'package:food_app_panel/pages/user/profile_page.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatefulWidget {
  dynamic data;
  UpdateUser({super.key, required this.data});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  @override
  void initState() {
    UpdateUserProvider provider =
        Provider.of<UpdateUserProvider>(context, listen: false);
    provider.userNameController.text = widget.data.ownersName;
    provider.userRestaurantNameController.text = widget.data.restaurantName;
    provider.userGmailController.text = widget.data.gmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Consumer<UpdateUserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: value.userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text("Name Update")),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: value.userRestaurantNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("RestaurantName Update")),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: value.userPasswordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter Password")),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          widget.data.password ==
                                  value.userPasswordController.text
                              ? updateUsername(
                                      ownersName: value.userNameController.text,
                                      restaurantName: value
                                          .userRestaurantNameController.text,
                                      gmail: widget.data.gmail)
                                  .then((v) =>
                                      userProvider.getRestaurantWonerData())
                                  .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content:
                                              Text("Update Successfully"))))
                                  .then((v) {
                                  value.userPasswordController.clear();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfilePage()));
                                })
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter wrong Password")));
                        },
                        child: const Text("update")))
              ],
            ),
          ),
        );
      },
    );
  }
}
