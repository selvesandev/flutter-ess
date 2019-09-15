import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;
  ProductCreate(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreate> {
  String titleValue;
  String descValue;
  double priceValue;
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product Title'),
              autofocus: true,
              onChanged: (String value) {
                setState(() {
                  titleValue = value;
                });
              },
            ),
            TextField(
              maxLines: 4,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Descripition'),
              onChanged: (String value) {
                setState(() {
                  descValue = value;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
              autofocus: true,
              onChanged: (String value) {
                setState(() {
                  priceValue = double.parse(value);
                });
              },
            ),
            Row(
              children: <Widget>[
                Switch(
                  value: switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
                Text('data')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                final Map<String, dynamic> product = {
                  'title': titleValue,
                  'description': descValue,
                  'price': priceValue,
                  'image': 'assets/barbell.jpg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ));
  }
}
