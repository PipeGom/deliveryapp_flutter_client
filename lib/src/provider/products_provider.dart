import 'dart:convert';
import 'dart:io';

import 'package:app_delivery/src/api/environment.dart';
import 'package:app_delivery/src/models/category.dart';
import 'package:app_delivery/src/models/product.dart';
import 'package:app_delivery/src/models/response_api.dart';
import 'package:app_delivery/src/models/user.dart';
import 'package:app_delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductsProvider {
  String _url = Environment.API_DELIVERY; // esto es el ip adrress
  String _api = '/api/products';
  BuildContext? context;
  User? sessionUser; // usuario de sesion

  Future? init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  } // inicializamos la clase

  Future<List<Product>> getByCategory(String idCategory) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
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
      Product product = Product.fromJsonList(data);

      return product.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<Stream?> create(Product product, List<File?> images) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken as String;

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i]!.openRead().cast()),
            await images[i]!.length(),
            filename: basename(images[i]!.path)));
      }
      request.fields['product'] = json.encode(product);
      final response = await request.send(); // ENVIAMOS LA PETICION
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error ${e}');
      return null;
    }
  }
}
