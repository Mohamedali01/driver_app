import 'package:driver_app/core/viewmodel/auth_provider.dart';
import 'package:driver_app/view/auth/register_view.dart';
import 'package:driver_app/view/map_view.dart';
import 'package:driver_app/wigets/circular_progress_widget.dart';
import 'package:driver_app/wigets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Provider.of<AuthProvider>(context);
    return (controller.isAuth)
        ? (MapView())
        : (controller.isLoading
            ? CircularProgressWidget()
            : Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Image.asset(
                              'assets/images/logo.png',
                              alignment: Alignment.topCenter,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: 'Login as a Rider',
                              fontSize: 28,
                              fontFamily: "semi bold",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _key,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration:
                                          InputDecoration(labelText: "Email"),
                                      validator: (String? value) {
                                        if (!value!.contains('@'))
                                          return 'email is not valid';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        controller.email = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          labelText: "Password"),
                                      validator: (value) {
                                        if (value!.length < 6)
                                          return 'password is too short!';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        controller.password = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 60,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.yellow),
                                ),
                                onPressed: () async {
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.save();
                                    await controller.signIn();
                                  }
                                },
                                child: Center(
                                  child: CustomText(
                                      text: 'Login',
                                      fontSize: 28,
                                      fontFamily: "semi bold",
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(RegisterView());
                              },
                              child: CustomText(
                                text: 'Do not have an account? Register Here',
                                fontSize: 17,
                                fontFamily: "semi bold",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
