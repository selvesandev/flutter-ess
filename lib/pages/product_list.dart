import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  ProductList(this.products, this.updateProduct);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(products[index]['image']),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ProductCreate(
                  product: products[index],
                  updatePorduct: updateProduct,
                  productIndex: index,
                );
              }));
              // Navigator.of(context).push(MaterialPageRoute() );
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
