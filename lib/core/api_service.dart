import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:todo_app/core/models/product_model.dart';
class ApiService{
  String _baseUrl;

  static ApiService _instance = ApiService._privateConstructor();

  ApiService._privateConstructor(){
    _baseUrl="https://todoapp-8ce8a.firebaseio.com/";
  }

  static ApiService getInstance(){
    if(_instance==null){
      return ApiService._privateConstructor();
    }
    else{
       return _instance;
    }

  }
  Future<List<Product>> getProducts() async {
    final response = await http.get(_baseUrl+"products.json");

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final productList = ProductList.fromJsonList(jsonResponse);
        return productList.products ;
        break;
      case HttpStatus.unauthorized:
      //Logger().e(jsonResponse);
      break;
      default:
     
    }
     return Future.error(jsonResponse);
  }

  Future addProducts(Product product) async {
    final jsonBody = json.encode(product.toJson());
    final response = await http.post(_baseUrl+"products.json",body:jsonBody);

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
      //Logger().e(jsonResponse);
      break;
      default:
     
    }
     return Future.error(jsonResponse);
  }


  Future removeProduct(String key) async {
    final response = await http.delete(_baseUrl+"products/$key.json");

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
      //Logger().e(jsonResponse);
      break;
      default:
     
    }
     return Future.error(jsonResponse);
  }
}