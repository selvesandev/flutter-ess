import 'package:flutter/material.dart';
import 'package:flutteress/models/product.dart';
import 'package:flutteress/pages/auth.dart';
import 'package:flutteress/pages/product.dart';
import 'package:flutteress/pages/products.dart';
import 'package:flutteress/pages/products_admin.dart';
import 'package:flutteress/scoped-models/main.dart';
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
  final MainModel _mainModal = MainModel();
  @override
  void initState() {
    _mainModal.authenticatedCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainModel = MainModel();
    return ScopedModel<MainModel>(
      model: _mainModal,
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
          '/': (BuildContext context) => mainModel.user == null ? AuthPage() : ProductsPage(mainModel),
                  
          '/admin': (BuildContext context) => ProductAdmin(mainModel),
          '/products': (BuildContext context) => ProductsPage(_mainModal)
        },

        onGenerateRoute: (RouteSettings setting) {
          final List<String> pathElement = setting.name.split('/');
          if (pathElement[0] != '') {
            return null;
          }

          if (pathElement[1] == 'product') {
            final String productId = pathElement[2];
            final Product product =
                mainModel.products.firstWhere((Product product) {
              return product.id == productId;
            });
            mainModel.selectProduct(productId);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(_mainModal));
        },
      ),
    );
  }
}
