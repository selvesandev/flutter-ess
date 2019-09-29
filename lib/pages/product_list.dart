import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductList extends StatelessWidget {
  // final List<Product> products;
  // final Function updateProduct;
  // final Function deleteProduct;
  ProductList();

  Widget _buildEditButtom(BuildContext context, index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductCreate();
        }));
        // Navigator.of(context).push(MaterialPageRoute() );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectProduct(index);
                  model.deleteProduct();
                }
                //this.deleteProduct();
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key(model.products[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            // AssetImage(model.products[index].image),
                            NetworkImage(model.products[index].image),
                      ),
                      title: Text(model.products[index].title),
                      subtitle:
                          Text('\$${model.products[index].price.toString()}'),
                      trailing: this._buildEditButtom(context, index, model)),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
