import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  final MainModel mainModel;
  ProductListPage(this.mainModel);

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductListPage> {
  @override
  initState() {
    super.initState();
    widget.mainModel.fetchProducts();
  }

  Widget _buildEditButtom(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(widget.mainModel.products[index].id);
        
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductCreate();
        }));
        Navigator.of(context).push(MaterialPageRoute());
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
                  model.selectProduct(widget.mainModel.products[index].id);
                  model.deleteProduct();
                }
                //this.deleteProduct();
              },
              background: Container(
                color: Colors.red,
              ),
              key: Key(widget.mainModel.products[index].title),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            // AssetImage(model.products[index].image),
                            NetworkImage(widget.mainModel.products[index].image),
                      ),
                      title: Text(widget.mainModel.products[index].title),
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
