import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/user/resistor_page.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
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
          body: Consumer<UserProvider>(builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Stack(children: [
                Opacity(
                  opacity: provider.isloading == true ? 0.5 : 1,
                  child: AbsorbPointer(
                    absorbing: provider.isloading,
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
                         provider.isloading==true?const Center(child: CircularProgressIndicator(color: Colors.red,),): SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                   
                                  provider.userloginprovider(provider.loginGmailController.text,provider.loginPassworController.text, context).then((value) {
                                    provider.loginGmailController.text=="";
                                    provider.loginPassworController.text=="";
                                  });
                                   
                                  },
                                  child: Text(
                                    "Login Page",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ))),
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
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: provider.isloading ? 1.0 : 0,
                      child: const CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ]),
            );
          })),
    );
  }
}
