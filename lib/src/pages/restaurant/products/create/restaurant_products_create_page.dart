import 'dart:io';

import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:app_delivery/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({super.key});

  @override
  _RestaurantProductsCreatePageState createState() =>
      _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState
    extends State<RestaurantProductsCreatePage> {
  // Controller
  RestaurantProductsCreateController _con =
      RestaurantProductsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva producto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _textFielName(),
          SizedBox(
            height: 15,
          ),
          _textFielDescription(),
          SizedBox(
            height: 15,
          ),
          _textFielPrice(),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1) as Widget,
                _cardImage(_con.imageFile2, 2) as Widget,
                _cardImage(_con.imageFile3, 3) as Widget,
              ],
            ),
          ),
          _dropDownCategories(_con.categories),
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _buttonCreate() {
    return Container(
        height:
            50, // alto especifico para evitar que ocupe toda la pantalla por un error
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: ElevatedButton(
          onPressed: _con.createProduct,
          child: Text(
            'Crear producto',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        ));
  }

  Widget _textFielName() {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          maxLines: 1,
          maxLength: 180,
          controller: _con.nameController,
          decoration: InputDecoration(
            hintText: 'Nombre del producto',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.local_pizza,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget? _cardImage(File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        // si se tiene un parametro se debe lanzar una funcion anonima
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
          ? Card(
              elevation: 3.0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ))
          : Card(
              elevation: 3.0,
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image(
                  image: AssetImage('assets/img/add_image.png'),
                  fit: BoxFit.cover,
                ),
              )),
    );
  }

  Widget _textFielPrice() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          maxLines: 1,
          controller: _con.priceController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            // los listView cuando son muy grandes se les debe restringir el tamano
            height: 100,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: MyColors.primaryColor,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Categorias',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_drop_down_circle,
                          color: MyColors.primaryColor),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text(
                      'Seleccionar categoria',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    items: _dropDownItems(categories),
                    value: _con.idCategory,
                    onChanged: (option) {
                      setState(() {
                        print('Categoria seleccionada $option');
                        _con.idCategory =
                            option; // Estableciendo el valor seleccionado a la variable id category
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>>? _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
          child: Text(category.name as String), value: category.id));
    });
    return list;
  }

  Widget _textFielDescription() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          maxLines: 3,
          maxLength: 255,
          controller: _con.descriptionController,
          decoration: InputDecoration(
            hintText: 'Descripción de la categoria',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
