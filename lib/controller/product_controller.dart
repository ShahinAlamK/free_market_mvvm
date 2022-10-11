import 'package:api/utils/status.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../network/product_web.dart';

class ProductsController extends ChangeNotifier{
  List<Product>_productList=[];
  List<Product>get productList=>_productList;


  bool _isLoading=true;
  bool get isLoading=>_isLoading;


  setLoading(bool loading)async{
    _isLoading=loading;
    notifyListeners();
  }

  String? get error=>_error;
  String?_error;


  setProductListModel(List<Product> dataList)async{
    _productList=dataList;
    setLoading(false);
    notifyListeners();
  }

  ProductsController(){
    fetchProducts();
  }

  Future fetchProducts()async{
    var response=await ProductsNetwork.fetchProduct();
    if(response is Success){
      setProductListModel(response.response as List<Product>);
    }if(response is Failure){
      _error=response.massage!.toString();
      notifyListeners();
    }
  }
}