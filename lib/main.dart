import 'package:app_delivery/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:app_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:app_delivery/src/pages/client/update/client_update_page.dart';
import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:app_delivery/src/pages/login/login_page.dart';
import 'package:app_delivery/src/pages/resgister/register_page.dart';
import 'package:app_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:app_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:app_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:app_delivery/src/pages/roles/roles_page.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner: false, // Quita el letrero de prueba
      initialRoute: 'login', //Donde arranca la app
      routes: ({
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/products/list': (BuildContext context) =>
            ClientProductsListPage(),
        'client/orders/create': (BuildContext context) =>
            ClientOrdersCreatePage(),
        'client/update': (BuildContext context) => ClientUpdatePage(),
        'restaurant/orders/list': (BuildContext context) =>
            RestaurantOrdersListPage(),
        'restaurant/categories/create': (BuildContext context) =>
            RestaurantCategoriesCreatePage(),
        'restaurant/products/create': (BuildContext context) =>
            RestaurantProductsCreatePage(),
        'delivery/orders/list': (BuildContext context) =>
            DeliveryOredersListPage(),
      }),
      theme: ThemeData(
          //fontFamily: 'NimbusSans',
          primaryColor: MyColors.primaryColor,
          appBarTheme: AppBarTheme(
              backgroundColor: MyColors.primaryColor,
              elevation: 0,
              actionsIconTheme: const IconThemeData(color: Colors.white))),
    );
  }
}
