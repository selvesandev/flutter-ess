import 'package:flutter/material.dart';
import 'package:flutteress/control.dart';
import 'package:flutteress/products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  // final Map initialProducts;
  // ProductManager({this.initialProducts});

  // @override
  // State<StatefulWidget> createState() {
  //   return _ProductManagerState();
  // }

  @override
  Widget build(BuildContext context) {
    print('Product Manager');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductControl(addProduct),
        ),
        Expanded(
          child: Products(
            products,
            deleteProduct: deleteProduct,
          ),
        )
      ],
    );
  }
}

// class _ProductManagerState extends State<ProductManager> {
  
//   @override
//   void initState() {
//     //the widget is a special property available in the state class by which it can access it's StatefullWidget's property
//     if (widget.initialProducts != null) _products.add(widget.initialProducts);
//     super.initState();
//   }

//   //the map will have string key and string value.
  

  
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Container(
//           margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
//       Expanded(child: Products(_products, deleteProduct: this._deleteProduct))
//     ]);
//   }
// }
