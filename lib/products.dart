import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  // final Function deleteProduct;
  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              Text(
                products[index]['title'],
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'MyFont'),
              ),
              SizedBox(
                width: 8,
              ),
              Text(products[index]['price'].toString())
            ]),
            color: Colors.red,
            padding: EdgeInsets.all(10),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + index.toString())
                    .then((bool value) {
                  if (value) {
                    // deleteProduct(index);
                  }
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget productCard = Center(
      child: Text('No products fuond please add some'),
    );

    if (products.length > 0)
      productCard = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );

    return productCard;
    // return products.length>0 ?  :Center(child: Text('No products found please add some'),);
  }
}
