import 'package:app_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:app_delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantCategoriesCreatePage extends StatefulWidget {
  const RestaurantCategoriesCreatePage({super.key});

  @override
  _RestaurantCategoriesCreatePageState createState() =>
      _RestaurantCategoriesCreatePageState();
}

class _RestaurantCategoriesCreatePageState
    extends State<RestaurantCategoriesCreatePage> {
  RestaurantCategoriesCreateController _con =
      RestaurantCategoriesCreateController();

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
          'Nueva categoria',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _textFielCategoryName(),
          SizedBox(
            height: 15,
          ),
          _textFielDescription()
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
          onPressed: _con.createCategory,
          child: Text(
            'Crear categoria',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(vertical: 15)),
        ));
  }

  Widget _textFielCategoryName() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: MyColors.primaryOpacitycolor,
            borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: _con.nameController,
          decoration: InputDecoration(
            hintText: 'Nombre de la categoria',
            border: InputBorder.none,
            hintStyle: TextStyle(color: MyColors.primaryColorDart),
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFielDescription() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
