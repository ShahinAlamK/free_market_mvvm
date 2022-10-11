import 'package:api/controller/product_controller.dart';
import 'package:api/controller/user_controller.dart';
import 'package:api/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'ui/home_page.dart';

void main() {
 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserController()),
        ChangeNotifierProvider(create: (_)=>ProductsController()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:HomePage()
      ),
    );
  }
}
