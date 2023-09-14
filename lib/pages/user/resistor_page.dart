import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/user/loginpage.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:provider/provider.dart';

class ResistorPage extends StatelessWidget {
  const ResistorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: provider.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: Icon(Icons.account_circle),
                    label: Text("Name"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: provider.restautantNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: Icon(Icons.account_circle),
                    label: Text("RestaurantName"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: provider.gmailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: Icon(Icons.email),
                    label: Text("Email"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: provider.passworController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
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
                        onPressed: () {
                          usersignup(
                              context: context,
                              ownersName: provider.nameController.text,
                              restautantName:
                                  provider.restautantNameController.text,
                              gmail: provider.gmailController.text,
                              password: provider.passworController.text);
                        },
                        child: const Text("Create Account"))),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                    text: TextSpan(
                        text: "Alredy Have An Account ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                          text: 'Login',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue))
                    ]))
              ],
            ),
          ),
        );
      }),
    );
  }
}
