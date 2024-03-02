import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";

class RestaurantOrdersListController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future? init(BuildContext context) {
    this.context = context;
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
}
