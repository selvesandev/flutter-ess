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

  Widget _buildTitleTextField() {
    return (TextField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: true,
      onChanged: (String value) {
        setState(() {
          titleValue = value;
        });
      },
    ));
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      autofocus: true,
      decoration: InputDecoration(labelText: 'Descripition'),
      onChanged: (String value) {
        setState(() {
          descValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      autofocus: true,
      onChanged: (String value) {
        setState(() {
          priceValue = double.parse(value);
        });
      },
    );
  }

  _onFormSubmit() {
    final Map<String, dynamic> product = {
      'title': titleValue,
      'description': descValue,
      'price': priceValue,
      'image': 'assets/barbell.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
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
              onPressed: _onFormSubmit,
            ),
            GestureDetector(onTap: _onFormSubmit,child: Container(child: Text('Guesture'),),)
          ],
        ));
  }
}
