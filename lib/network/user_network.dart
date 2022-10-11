import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import '../model/user_model.dart';
import '../utils/status.dart';

class UserNetwork{


  static Future<Object> getUser()async{
    try{
      var response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      if(response.statusCode==200){
        return Success(response:userModelFromJson(response.body));
      }return Failure(
        code: 101,massage:"Invalid Response"
      );
    }on HttpException{
      return Failure(
        code:103,massage:"Worn Api Host"
      );
    }on SocketException{
      return Failure(
        code:102,massage:"No Internet Connection"
      );
    }on FormatException{
      return Failure(
        code: 404,massage:"Bad Format"
      );
    }catch(error){
      return Failure(
        code: 502,massage: error.toString()
      );
    }
  }

}