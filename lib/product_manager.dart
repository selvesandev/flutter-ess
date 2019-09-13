import 'package:flutter/material.dart';
import 'package:flutteress/control.dart';
import 'package:flutteress/products.dart';

class ProductManager extends StatefulWidget {
  final Map initialProducts;
  ProductManager({this.initialProducts});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  final List<Map<String, String>> _products = [];

  @override
  void initState() {
    //the widget is a special property available in the state class by which it can access it's StatefullWidget's property
    if (widget.initialProducts != null) _products.add(widget.initialProducts);
    super.initState();
  }

  //the map will have string key and string value.
  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
      Expanded(child: Products(_products,deleteProduct: this._deleteProduct))
    ]);
  }
}
