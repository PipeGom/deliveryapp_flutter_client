import "package:app_delivery/src/models/category.dart";
import "package:app_delivery/src/models/response_api.dart";
import "package:app_delivery/src/models/user.dart";
import "package:app_delivery/src/provider/categories_provider.dart";
import "package:app_delivery/src/utils/my_snackbar.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class RestaurantCategoriesCreateController {
  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  User? user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user!);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debe ingresar todos los campos');
      return;
    }

    Category category = new Category(name: name, description: description);

    ResponseApi responseApi =
        await _categoriesProvider.create(category) as ResponseApi;

    MySnackbar.show(context, responseApi.message as String);

    if (responseApi?.success ?? false) {
      // limpiamos el formulario luego de una creacion exitosa
      nameController.text = '';
      descriptionController.text = '';
    }
  }
}
