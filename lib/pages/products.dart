import 'package:flutter/material.dart';
import 'package:flutteress/product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;
  ProductsPage(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
                height: 100,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Choose'),
                )),
            ListTile(
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Flutter Ecommerce'),
      ),
      body: ProductManager(this.products, this.addProduct, this.deleteProduct),
    );
  }
}
