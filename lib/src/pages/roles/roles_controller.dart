import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";

class RolesController {
  BuildContext? context;
  Function? refresh;

  User? user;
  SharedPref? sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    //Obteniendo el usuario de sesion
    user = User.fromJson(await sharedPref?.read('user'));
    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }
}
