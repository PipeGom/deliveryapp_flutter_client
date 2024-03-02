import 'package:app_delivery/src/models/rol.dart';
import 'package:app_delivery/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = RolesController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un rol'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
        child: ListView(
            children: (_con.user != null && _con.user!.roles != null)
                ? _con.user!.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : []),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route!);
      },
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.png'),
              image: NetworkImage(rol.image ?? ''),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            rol.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
