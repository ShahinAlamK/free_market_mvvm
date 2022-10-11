import 'dart:convert';
import 'dart:io';

import 'package:api/model/product_model.dart';
import 'package:api/utils/api_key.dart';
import 'package:api/utils/status.dart';
import 'package:http/http.dart' as http;

class ProductsNetwork{


  static Future<Object>fetchProduct()async{
    try{
      var response=await http.get(Uri.parse(productAPi)).timeout(Duration(seconds: 10));
      if(response.statusCode==200){
        final decode=jsonDecode(response.body);
        List<Product> listProduct=(decode['products'] as List).map((e) => Product.fromJson(e)).toList();

       return Success(response:listProduct);
      }return Failure(code: 105,massage:"Invalid Host");
    }on SocketException{
      return Failure(code:202,massage: "No Internet");
    }on HttpException{
      return Failure(code:202,massage: "Invalid Api");
    }on FormatException{
      return Failure(code:202,massage: "Bad Request");
    }catch(error){
      return Failure(code:202,massage: "Something Error");
    }
  }
}