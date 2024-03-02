import 'package:app_delivery/src/pages/resgister/register_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              child: _textRegister(),
              top: 65,
              left: 27,
            ),
            Positioned(
              child: _iconBack(),
              top: 51,
              left: -5,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    const SizedBox(
                      height: 30,
                    ),
                    _textFieldEmail(),
                    _textFielName(),
                    _textFielLastName(),
                    _textFielPhone(),
                    _textFielPassword(),
                    _textFielConfirmPassword(),
                    _buttonLogin()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageUser() {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/img/user_profile.png'),
      radius: 60,
      backgroundColor: Colors.grey[200],
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

  Widget _textRegister() {
    return Text(
      'REGISTRO',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'NimbusSans'),
    );
  }

  Widget _textFieldEmail() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: _con.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Correo electronico',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.mail,
              color: MyColors.primaryColor,
            ),
          ),
        ));
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

  Widget _textFielPassword() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          obscureText: true,
          controller: _con.passwordController,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFielConfirmPassword() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          obscureText: true,
          controller: _con.confirmPasswordController,
          decoration: InputDecoration(
            hintText: 'Confirmar Contraseña',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock_outline,
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
          onPressed: _con.register,
          child: Text(
            'Registro',
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
}
