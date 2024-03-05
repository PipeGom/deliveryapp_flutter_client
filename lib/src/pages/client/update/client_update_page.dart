import 'package:app_delivery/src/pages/client/update/client__update_controller.dart';
import 'package:app_delivery/src/pages/resgister/register_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  ClientUpdateController _con = new ClientUpdateController();

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
        title: Text('Editar perfil'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              _imageUser(),
              const SizedBox(
                height: 30,
              ),
              _textFielName(),
              _textFielLastName(),
              _textFielPhone(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonLogin(),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile!)
            : _con.user?.image != null
                ? NetworkImage(_con.user!.image!)
                : AssetImage('assets/img/user_profile_2.png') as ImageProvider,
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _iconBack() {
    return IconButton(
      onPressed: _con.back,
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  Widget _textFielName() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: _con.nameController,
          decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFielLastName() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: _con.lastnameController,
          decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFielPhone() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: _con.phoneController,
          decoration: InputDecoration(
            hintText: 'Telefono',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _buttonLogin() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: ElevatedButton(
          onPressed: _con.isEnable ? _con.update : null,
          child: Text(
            'Actualizar información',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        ));
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
