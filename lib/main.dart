import 'package:flutter/material.dart';
import 'package:flutteress/pages/product.dart';
import 'package:flutteress/pages/products.dart';
import 'package:flutteress/pages/products_admin.dart';
import 'package:flutteress/products.dart';
// import 'package:flutteress/pages/products.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
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
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.deepOrange),
      // home: AuthPage(),
      routes: {
        '/admin': (BuildContext context) => ProductAdmin(this._addProduct, this._deleteProduct),
        '/': (BuildContext context) =>
            ProductsPage(this._products)
      },
      onGenerateRoute: (RouteSettings setting) {
        final List<String> pathElement = setting.name.split('/');
        print(pathElement);
        if (pathElement[0] != '') {
          return null;
        }

        if (pathElement[1] == 'product') {
          final int index = int.parse(pathElement[2]);

          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'], _products[index]['image']),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => Products(_products));
      },
    );
  }
}
