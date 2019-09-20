import 'package:flutter/material.dart';
import 'package:flutteress/products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    print('Product Manager');
    return Column(
      children: <Widget>[
        Expanded(
          child: Products(
            products,
            //deleteProduct: deleteProduct,
          ),
        )
      ],
    );
  }
}

