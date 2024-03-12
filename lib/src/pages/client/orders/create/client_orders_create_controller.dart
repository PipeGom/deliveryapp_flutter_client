import "package:app_delivery/src/models/product.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

class ClientOrdersCreateController {
  BuildContext? context;
  Function? refresh;
  Product? product;

  int counter = 1;
  double? productPrice;

  SharedPref _sharedPref = SharedPref();
  List<Product> selectedProducts = [];
  double total = 0;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    selectedProducts = Product.fromJsonList(await _sharedPref.read('order'))
        .toList; // Para leer los otros items que se hayan agregado

    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    selectedProducts.forEach((product) {
      total = total + (product.quantity! * (product.price as num));
    });
    refresh!();
  }

  void addItem(Product product) {
    int index = selectedProducts.indexWhere((p) =>
        p.id == product!.id); // para saber que producto estamos modificando
    selectedProducts[index].quantity =
        selectedProducts[index].quantity! + 1; // la idea es anadir un elemento
    _sharedPref.save('order', selectedProducts);
    getTotal();
    refresh!();
  }

  void removeItem(Product product) {
    if (product.quantity! > 1) {
      int index = selectedProducts.indexWhere((p) =>
          p.id == product!.id); // para saber que producto estamos modificando
      selectedProducts[index].quantity = selectedProducts[index].quantity! -
          1; // la idea es borrar un elemento
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProducts.removeWhere((p) => p.id == product.id);
    _sharedPref.save('order',
        selectedProducts); // una vez lo eliminemos se guardara en el shred
    getTotal();
  }
}
