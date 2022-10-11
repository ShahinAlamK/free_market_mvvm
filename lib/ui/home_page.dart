import 'package:api/controller/product_controller.dart';
import 'package:api/controller/user_controller.dart';
import 'package:api/model/product_model.dart';
import 'package:api/model/user_model.dart';
import 'package:api/ui/details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<Offset> offsetAnimation;

  Duration second = Duration(seconds: 4);
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: second);
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<UserController>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("Free-Market"),
        ),
        body: Consumer<ProductsController>(builder: (_, data, child) {
          if (data.error != null) {
            return Center(
              child: Text(data.error!),
            );
          }
          if (data.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.productList.length,
              itemBuilder: (_, index) {
                Product product = data.productList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsPage(
                                  product: product,
                                )));
                  },
                  child: Container(
                    height: 120,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3))
                        ]),
                    child: Row(
                      children: [
                        Hero(
                          tag: "images",
                          child: Container(
                            height: size.height,
                            width: size.width * .3,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(product.images![0]))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              product.description!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.orange[300],
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Text(
                                      "price:${product.price.toString()}\$",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Text(
                                      "rating: ${product.rating.toString()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green[200],
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Text(
                                      "stock:${product.stock.toString()}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              });
        }));
  }
}
