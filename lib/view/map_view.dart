import 'package:driver_app/core/viewmodel/map_provider.dart';
import 'package:driver_app/wigets/custom_text.dart';
import 'package:driver_app/wigets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mainController = Provider.of<MapProvider>(context);
    return Scaffold(

      drawer: DrawerWidget(),
      key: scaffoldKey,
      appBar: AppBar(
      leading: Container(),
        title: Text('Main Screen'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 350),
            child: GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(37.43296265331129, -122.08832357078792),
                  tilt: 59.440717697143555,
                  zoom: 10),
              onMapCreated: (controller) async{
                mainController.newGoogleMapController = controller;
               await mainController.getLocation();
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.7, 0.7),
                        color: Colors.black,
                        spreadRadius: 0.5,
                        blurRadius: 10)
                  ],
                ),
                child: CircleAvatar(
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Hi there,',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    CustomText(
                      text: 'Where to?,',
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 0.5),
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          title: TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Search Drop Off',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _buildLisTileWidget(
                      title: 'Add Home',
                      subTitle: 'Your living home address',
                      icon: Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade400,
                    ),
                    _buildLisTileWidget(
                      title: 'Add Work',
                      subTitle: 'Your office address',
                      icon: Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildLisTileWidget(
      {required String title, required String subTitle, required Icon icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          subtitle: CustomText(
            text: subTitle,
            color: Colors.grey,
            fontSize: 14,
          ),
          leading: icon,
          title: CustomText(
            text: title,
            fontSize: 18,
            color: Colors.black,
            isBold: true,
          ),
        ),
      ],
    );
  }
}
