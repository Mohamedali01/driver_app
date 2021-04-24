import 'package:driver_app/core/viewmodel/auth_provider.dart';
import 'package:driver_app/view/map_view.dart';
import 'package:driver_app/wigets/circular_progress_widget.dart';
import 'package:driver_app/wigets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
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
                            Image.asset(
                              'assets/images/logo.png',
                              alignment: Alignment.topCenter,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: 'Register as a Rider',
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
                                          InputDecoration(labelText: "Name"),
                                      validator: (value) {
                                        if (value!.length < 4)
                                          return 'name is too short';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        controller.name = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
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
                                      decoration: InputDecoration(
                                        labelText: "Phone",
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.length != 11 ||
                                            !value.startsWith('01'))
                                          return 'phone is not valid';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        controller.phone = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                      ),
                                      obscureText: true,
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
                                    await controller
                                        .createUserWithEmailAndPass();
                                  }
                                },
                                child: Center(
                                  child: CustomText(
                                    text: 'Register',
                                    fontSize: 28,
                                    fontFamily: "semi bold",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CustomText(
                                text: 'Do not have an account? Login Here',
                                fontSize: 17,
                                fontFamily: "semi bold",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
