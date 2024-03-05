import "dart:convert";
import "dart:io";
import "package:app_delivery/src/models/response_api.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/provider/users_provider.dart";
import "package:app_delivery/src/utils/my_snackbar.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:image_picker/image_picker.dart";
import "package:sn_progress_dialog/progress_dialog.dart";

class ClientUpdateController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? lastnameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;
  bool isEnable = true;
  User? user;
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    user = User?.fromJson(await _sharedPref.read('user'));

    nameController!.text = user!.name!;
    lastnameController!.text = user!.lastname!;
    phoneController!.text = user!.phone!;

    refresh();
  }

  void update() async {
    String name = nameController!.text.trim();
    String lastname = lastnameController!.text.trim();
    String phone = phoneController!.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    _progressDialog!.show(max: 100, msg: 'Espere un momento.. ');
    isEnable = false;

    User myUser =
        User(id: user!.id, name: name, lastname: lastname, phone: phone);

    Stream? stream = await usersProvider.update(myUser, imageFile);

    stream!.listen((res) async {
      //ResponseApi responseApi = await usersProvider.create(user);
      // Cierra el dialogo porque ya se cargo la imagen
      _progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message!);

      if (responseApi.success) {
        user = await usersProvider
            .getById(myUser!.id!); // Obteniendo el usuario de la base de datos
        _sharedPref.save(
            'user', user!.toJson()); // guardar el usuario en sesion
        Future.delayed(Duration(seconds: 3), () {
          if (context != null) {
            Navigator.pushNamedAndRemoveUntil(
                context!, 'client/products/list', (route) => false);
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
