import 'package:flutter/material.dart';
import 'package:flutteress/models/product.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:flutteress/widgets/products/price_tag.dart';
import 'package:flutteress/widgets/ui_element/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePrice() {
    return Container(
      margin: EdgeInsets.all(10),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        TitleDefault(product.title.toString()),
        SizedBox(
          width: 8,
        ),
        PriceTag(product.price.toString())
      ]),
      padding: EdgeInsets.all(10),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.info),
              onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + model.products[productIndex].id)
                  .then((bool value) {
                if (value) {
                  // deleteProduct(index);
                }
              }),
            ),
            ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
                return IconButton(
                  icon: Icon(!model.displayedProducts[productIndex].isFavourite
                      ? Icons.favorite_border
                      : Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    model.selectProduct(model.products[productIndex].id);
                    model
                        .toggleFavouriteStatus(model.products[productIndex].id);
                  },
                );
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          // Image.asset(product.image),
          FadeInImage(
            image: NetworkImage(product.image),
            placeholder: AssetImage('assets/background.jpg'),
            height: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          _buildTitlePrice(),
          Text(product.email),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
