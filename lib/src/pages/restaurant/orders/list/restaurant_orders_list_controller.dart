import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";

class RestaurantOrdersListController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Function? refresh;

  User? user;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout() {
    if (context != null) {
      _sharedPref
          .logout(context!); // Using null-aware operator to assert non-null
    }
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
