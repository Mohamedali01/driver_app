import 'package:driver_app/wigets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 250,
            width: 300,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/user_icon.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Profile Name",
                        isBold: true,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10,),
                      CustomText(
                        text: "Visit Profile",
                        isBold: true,
                        fontSize: 20,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history,size: 28,),
            title: CustomText(
              text: "History",
              fontSize: 20,

            ),
          ),ListTile(
            leading: Icon(Icons.person,size: 28,),
            title: CustomText(
              text: "Visit Profile",
              fontSize: 20,
            ),
          ),ListTile(
            leading: Icon(Icons.info,size: 28,),
            title: CustomText(
              text: "About",
              fontSize: 20,

            ),
          ),
        ],
      ),
    );
  }
}
