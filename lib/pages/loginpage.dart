import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/pages/resistor_page.dart';
import 'package:food_app_panel/provider/App_provider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
          appBar: AppBar(),
          body: Consumer<AppProvider>(builder: (context, provider, child) {
            return FutureBuilder(
              future: getRestaurantWoners(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //List<UserApi> data = snapshot.data;
                  provider.restaurantList = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email Address";
                              }
                              return null;
                            },
                            controller: provider.loginGmailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              prefixIcon: Icon(Icons.email),
                              label: Text("Email"),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                            controller: provider.loginPassworController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              prefixIcon: Icon(Icons.lock),
                              label: Text("Password"),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () async {
                                    for (var i = 0;
                                        i < provider.restaurantList.length;
                                        i++) {
                                      if (provider.loginGmailController.text ==
                                              provider
                                                  .restaurantList[i].gmail &&
                                          provider.loginPassworController
                                                  .text ==
                                              provider
                                                  .restaurantList[i].password) {
                                        provider
                                            .userloginSharedPrefrance(context);
                                        // provider
                                        //     .userloginSharedPrefrance(context);
                                        // SharedPreferences sharedPreferences =
                                        //     await SharedPreferences
                                        //         .getInstance();
                                        // sharedPreferences
                                        //     .setString(
                                        //         "email",
                                        //         provider
                                        //             .logingmailcontroller.text)
                                        //     .then((value) =>
                                        //         Navigator.pushReplacement(
                                        //             context,
                                        //             MaterialPageRoute(
                                        //               builder: (context) =>
                                        //                   BottomNav(),
                                        //             )));

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BottomNav()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Email And Password Check Please')),
                                        );
                                        break;
                                      }
                                    }

                                    // if (_formKey.currentState!.validate()) {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(
                                    //     const SnackBar(
                                    //         content: Text('Processing Data')),
                                    //   );
                                    // }
                                  },
                                  child: const Text("Login Page"))),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "You Have No Account ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ResistorPage())),
                                    text: 'Create Account',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue))
                              ]))
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          })),
    );
  }
}
