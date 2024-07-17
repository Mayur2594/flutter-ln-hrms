import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:ln_hrms/controllers/controller.authentication.dart';
import 'package:ln_hrms/controllers/controller.common.dart';
import 'package:ln_hrms/main.dart';
import 'package:ln_hrms/views/view.forgotpassword.dart';

final AuthenticationController AuthCtrl = Get.put(AuthenticationController());

class PasssowrdFieldView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        controller: AuthCtrl.passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: Icon(
              AuthCtrl.obscureText.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              AuthCtrl.toggleVisibility();
            },
          ),
        ),
        obscureText: AuthCtrl.obscureText.value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 0) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
      );
    });
  }
}

class AuthenticationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: Svg('lib/assets/svg/wave2.svg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Column(
                          children: [
                            Text(
                              "Signin",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Form(
                            key: AuthCtrl.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: AuthCtrl.usernameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Username (Mobile / Email)',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username (Mobile / Email)';
                                    }
                                    // Simple email validation
                                    if (value.length < 10) {
                                      return 'Please enter a valid username';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                PasssowrdFieldView(),
                                const SizedBox(height: 15),
                                const Center(
                                  child: MaterialButton(
                                    onPressed: null,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    74, 20, 140, 1)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF654ea3),
                                      Color(0xFFeaafc8),
                                    ]),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    onPressed: () {
                                      if (AuthCtrl.formKey.currentState
                                              ?.validate() ??
                                          false) {
                                        AuthCtrl.authenticateUser(context);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 6.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Signin",
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                )))));
  }
}
