import 'package:api/utils/api_key.dart';
import 'package:http/http.dart' as http;

class NewsNetwork{

  Uri url=Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=sports&par_page=1&apiKey=3120fffd5de5418796fbab343da2dacc");

  Future fetchNetwork()async{
    try{
      final response=await http.get(url);
      if(response.statusCode==200){
        print(response.body);
        return response.body;
      }
    }catch(error){
      print(error);
    }
  }

}