import 'package:driver_app/core/viewmodel/auth_provider.dart';
import 'package:driver_app/view/auth/login_view.dart';
import 'package:driver_app/view/map_view.dart';
import 'package:driver_app/wigets/circular_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ControlView extends StatefulWidget {
  @override
  _ControlViewState createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  void initState() {
    super.initState();
  Permission.location.request();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthProvider>(context);
    return controller.isAuth
        ? FutureBuilder(
      future: controller.autoLogin(),
        builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting)
              return CircularProgressWidget();
            if (snapShot.connectionState == ConnectionState.done)
              return MapView();
            else
              return Container();
          })
        : LoginView();
  }
}
