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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    // return (TextField(
    //   decoration: InputDecoration(labelText: 'Product Title'),
    //   autofocus: true,
    //   onChanged: (String value) {
    //     setState(() {
    //       titleValue = value;
    //     });
    //   },
    // ));

    return (TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: true,
      // autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and 5 character long';
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          titleValue = value;
        });
      },
    ));
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      autofocus: true,
      decoration: InputDecoration(labelText: 'Descripition'),
      validator: (String value) {
        if (value.isEmpty && value.length < 10) {
          return 'Description is required and 10 character long';
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          descValue = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      autofocus: true,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^\d{0,8}(\.\d{1,4})?$').hasMatch(value)) {
          return 'Price is required and should be a number';
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          priceValue = double.parse(value);
        });
      },
    );
  }

  _onFormSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
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
    //gives information about the form's sate

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
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
            GestureDetector(
              onTap: _onFormSubmit,
              child: Container(
                child: Text('Guesture'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
