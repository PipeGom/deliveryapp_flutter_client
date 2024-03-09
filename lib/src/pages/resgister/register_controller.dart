import "dart:convert";
import "dart:io";

import "package:app_delivery/src/models/response_api.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/provider/users_provider.dart";
import "package:app_delivery/src/utils/my_snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:image_picker/image_picker.dart";
import "package:sn_progress_dialog/progress_dialog.dart";

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;
  bool isEnable = true;

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (confirmpassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, ' La contraseña debe tener al menos 6 caracteres');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    _progressDialog!.show(max: 100, msg: 'Espere un momento.. ');
    isEnable = false;

    User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password);

    Stream? stream = await usersProvider.createWithImage(user, imageFile);

    stream!.listen((res) {
      //ResponseApi responseApi = await usersProvider.create(user);
      // Cierra el dialogo porque ya se cargo la imagen
      _progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');

      MySnackbar.show(context, responseApi.message ?? "Error");

      if (responseApi.success == true) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context != null) {
            Navigator.pushReplacementNamed(context!, 'login');
          }
        });
      } else {
        isEnable = true;
      }
    });
  }

  void back() {
    if (context != null) {
      Navigator.pop(context!);
    }
  }

  Future selectImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMERA'));
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context!,
        builder: (buildContext) {
          return alertDialog;
        });
  }
}
