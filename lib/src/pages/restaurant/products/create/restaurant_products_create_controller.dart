import "dart:convert";
import "dart:io";

import "package:app_delivery/src/models/category.dart";
import "package:app_delivery/src/models/product.dart";
import "package:app_delivery/src/models/response_api.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/provider/categories_provider.dart";
import "package:app_delivery/src/provider/products_provider.dart";
import "package:app_delivery/src/utils/my_snackbar.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import "package:image_picker/image_picker.dart";
import "package:sn_progress_dialog/progress_dialog.dart";

class RestaurantProductsCreateController {
  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  MoneyMaskedTextController priceController = new MoneyMaskedTextController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = ProductsProvider();
  User? user;
  SharedPref sharedPref = SharedPref();

  List<Category> categories = [];
  String? idCategory; //Almacena el id de la categoria seleccionada

  // Imagenes
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  ProgressDialog? _progressDialog;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user!);
    _productsProvider.init(context, user as User);

    getCategories();
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = priceController.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las tres imagenes');
      return;
    }

    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona la categoria del producto');
      return;
    }
    Product product = Product(
        name: name,
        description: description,
        price: price,
        idCategory: int.parse(idCategory as String));

    List<File> images = [];
    images.add(imageFile1 as File);
    images.add(imageFile2 as File);
    images.add(imageFile3 as File);

    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    Stream? stream = await _productsProvider.create(product, images);
    stream!.listen((res) {
      _progressDialog!.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message as String);

      if (responseApi.success == true) {
        resetValues();
      }
    });

    print('Formulario Producto: ${product.toJson()}');
  }

  void resetValues() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '0.0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refresh!();
  }

  // Image Source Tipo de seleccion si es de galeria o camara
  Future selectImage(ImageSource imageSource, int numberFile) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      print('Entre a la seleccion de imagenes');
      // si es la primera foto
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text('GALERIA'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberFile);
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
