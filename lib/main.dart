import 'package:flutter/material.dart';
import 'package:flutteress/pages/auth.dart';
import 'package:flutteress/pages/product.dart';
import 'package:flutteress/pages/products.dart';
import 'package:flutteress/pages/products_admin.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:flutteress/widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    final mainModel=MainModel();
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            // buttonColor: Colors.greenAccent,
            fontFamily: 'MyFont'),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/admin': (BuildContext context) => ProductAdmin(),
          '/products': (BuildContext context) => ProductsPage(mainModel)
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
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(mainModel));
        },
      ),
    );
  }
}
