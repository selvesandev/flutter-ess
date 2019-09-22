import 'package:flutter/material.dart';
import 'package:flutteress/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function deleteProduct;
  Products(this.products);


  @override
  Widget build(BuildContext context) {
    Widget productCard = Center(
      child: Text('No products fuond please add some'),
    );

    if (products.length > 0)
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );

    return productCard;
    // return products.length>0 ?  :Center(child: Text('No products found please add some'),);
  }
}
