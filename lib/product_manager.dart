import 'package:flutter/material.dart';
import 'package:flutteress/control.dart';
import 'package:flutteress/products.dart';

class ProductManager extends StatefulWidget {
  final String initialProducts;
  ProductManager({this.initialProducts});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  final List<String> _products = [];

  @override
  void initState() {
    //the widget is a special property available in the state class by which it can access it's StatefullWidget's property
    _products.add(widget.initialProducts);
    super.initState();
  }

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
      Products(_products)
    ]);
  }
}
