import 'package:app_delivery/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DeliveryOredersListPage extends StatefulWidget {
  const DeliveryOredersListPage({super.key});

  @override
  _DeliveryOredersListPageState createState() =>
      _DeliveryOredersListPageState();
}

class _DeliveryOredersListPageState extends State<DeliveryOredersListPage> {
  DeliveryOrdersListController _con = DeliveryOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.key,
        appBar: AppBar(
          leading: _menuDrawer(),
        ),
        drawer: _drawer(),
        body: Center(
          child: Text('Delivery Orders List '),
        ));
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre de usuario:',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    'Email:',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    'Telefono:',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 7),
                    child: FadeInImage(
                      image: AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            title: Text('Editar perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          ListTile(
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outlined),
          ),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
