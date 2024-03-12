import 'dart:convert';
import 'dart:io';

import 'package:app_delivery/src/api/environment.dart';
import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider {
  String _url = Environment.API_DELIVERY; // esto es el ip adrress
  String _api = '/api/categories';
  BuildContext? context;
  User? sessionUser; // usuario de sesion

  Future? init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  } // inicializamos la clase

  Future<List<Category>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken as String
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context!, sessionUser!.id as String);
      }
      final data = json.decode(res.body); // CATEGORIAS
      Category category = Category.fromJsonList(data);
      print(
          'Estas son las categorias que se deberian mostrar en el drawer: ${category}');
      return category.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<ResponseApi?> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken as String
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        SharedPref().logout(context!, sessionUser!.id as String);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
