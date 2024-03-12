import "package:app_delivery/src/models/product.dart";
import "package:app_delivery/src/utils/shared_pref.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

class ClientProductsDetailController {
  BuildContext? context;
  Function? refresh;
  Product? product;

  int counter = 1;
  double? productPrice;

  SharedPref _sharedPref = SharedPref();
  List<Product> selectedProducts = [];

  Future? init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;

    //_sharedPref.remove('order');
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order'))
        .toList; // Para leer los otros items que se hayan agregado

    selectedProducts.forEach((p) {
      print(
          'Producto seleccionado: ${p.toJson()}'); // esto se ejecuta cuando leugo de agregar un producto abrimos otro
    });
    refresh();
  }

  void addToBar() {
    int index = selectedProducts.indexWhere((p) => p.id == product!.id);

    if (index == -1) {
      // PRODUCTOS SELECCIONADOS NO EXISTE ESE Producto
      if (product!.quantity != null) {
        product!.quantity = 1;
      }

      selectedProducts.add(product as Product);
    } else {
      selectedProducts[index].quantity = counter;
    }
    _sharedPref.save('order',
        selectedProducts); // vamos a guargar la lista de productos para crear la ordern
    Fluttertoast.showToast(msg: 'Producto agregado');
  }

  void addItem() {
    counter = counter + 1;
    productPrice = product!.price! * counter;
    product!.quantity = counter;
    refresh!();
  }

  void removeItem() {
    if (counter > 1) {
      counter = counter - 1;
      productPrice = product!.price! * counter;
      product!.quantity = counter;
      refresh!();
    }
  }

  void close() {
    Navigator.pop(context!);
  }
}
