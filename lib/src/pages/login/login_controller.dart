import "package:app_delivery/src/models/response_api.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/provider/users_provider.dart";
import "package:app_delivery/src/utils/my_snackbar.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('Usuario: ${user.toJson()}');

    if (user.sessionToken != null) {
      if (user.roles != null && user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        String? route = user.roles?[0].route;
        if (route != null) {
          Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
        }
      }
    }
  }

  void goToRegisterPage() {
    if (context != null) {
      Navigator.pushNamed(context!, 'register');
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    MySnackbar.show(context, responseApi.message ?? "Error");

    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      print('Usuario Logeado ${user.toJson()}');

      // Verificamos si el usuario tiene uno o mas perfiles
      if (user.roles != null && user.roles!.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      } else {
        String? route = user.roles?[0].route;
        if (route != null) {
          Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
        }
      }
    } else {
      MySnackbar.show(context, responseApi.message ?? "Error");
    }

    print('Email: $email');
    print('password $password');
  }
}
