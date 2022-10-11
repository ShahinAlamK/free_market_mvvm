import 'package:api/model/product_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title:Text(widget.product.title!),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child:Stack(
              children: [

                ClipRRect(
                  borderRadius:BorderRadius.circular(10),
                  child: PageView(
                    onPageChanged:(val){
                      setState(() {
                        _currentIndex=val;
                      });
                    },
                    physics: BouncingScrollPhysics(),
                    children:List.generate(widget.product.images!.length, (index) =>Hero(
                        tag: "images",
                        child: Image.network(widget.product.images![index],fit: BoxFit.cover,))),
                  ),
                ),
                Positioned(
                  bottom: 10,
                    right: 50,
                    left: 50,
                    child:Center(child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:List.generate(widget.product.images!.length, (index){
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height:7,
                          width: index==_currentIndex?20:10,
                          decoration: BoxDecoration(
                              color: index==_currentIndex?Colors.red:Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        );
                      })
                    ))),

              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height:50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Flexible(
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Colors.deepOrange[200],borderRadius: BorderRadius.circular(3),),
                      child: Text("Price: ${widget.product.price!.toString()}\$",style: TextStyle(fontSize: 12))),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Colors.green[200],borderRadius: BorderRadius.circular(3),),
                      child: Text("Rating: ${widget.product.rating!.toString()}",style: TextStyle(fontSize: 12))),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Colors.yellow[200],borderRadius: BorderRadius.circular(3),),
                      child: Text("${widget.product.category!.toString()}",style: TextStyle(fontSize: 12))),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color:Colors.blue[200],borderRadius: BorderRadius.circular(3),),
                      child: Text("Brand: ${widget.product.brand!.toString()}",style: TextStyle(fontSize: 12))),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10)
            ),
            child:Text(widget.product.description!,style: TextStyle(fontSize: 16),),
          )
        ],
      ),
    );
  }
}

