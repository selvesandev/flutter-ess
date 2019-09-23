import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;
  ProductList(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButtom(BuildContext context, index) {
    return IconButton(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              this.deleteProduct(index);
            }
            //this.deleteProduct();
          },
          background: Container(
            color: Colors.red,
          ),
          key: Key(products[index]['title']),
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(products[index]['image']),
                  ),
                  title: Text(products[index]['title']),
                  subtitle: Text('\$${products[index]['price'].toString()}'),
                  trailing: this._buildEditButtom(context, index)),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
