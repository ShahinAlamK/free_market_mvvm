import 'package:api/model/user_model.dart';
import 'package:api/network/user_network.dart';
import 'package:api/utils/status.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';


class UserController extends ChangeNotifier{


  List<UserModel>_listUser=[];
  List<UserModel>get listUser=>_listUser;


  bool _isLoading=false;
  bool get isLoading=>_isLoading;


  setLoading(bool loading)async{
    _isLoading=loading;
    notifyListeners();
  }


  setUserListModel(List<UserModel>dataList)async{
    _listUser=dataList;
    notifyListeners();
  }

  UserController(){
    fetchUser();
  }

 fetchUser()async{
    setLoading(true);
    var response=await UserNetwork.getUser();
    if(response is Success){
      setLoading(false);
      setUserListModel(response.response as List<UserModel>);
      notifyListeners();
    }if(response is Failure){
      print(response.massage);
    }
  }

}