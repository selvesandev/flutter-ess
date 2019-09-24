import 'package:flutter/material.dart';
import 'package:flutteress/models/product.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;
  final Product product;
  final Function updatePorduct;
  final int productIndex;
  ProductCreate(
      {this.addProduct, this.updatePorduct, this.product, this.productIndex});

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
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/lady.jpeg'
  };
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
      initialValue: widget.product == null ? '' : widget.product.title,
      // autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and 5 character long';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['title'] = value;
        // titleValue = value;
      },
    ));
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product.description,
      autofocus: true,
      decoration: InputDecoration(labelText: 'Descripition'),
      validator: (String value) {
        if (value.isEmpty && value.length < 10) {
          return 'Description is required and 10 character long';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
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
        _formData['price'] = double.parse(value);
      },
    );
  }

  _onFormSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // final Map<String, dynamic> product = {
    //   'title': titleValue,
    //   'description': descValue,
    //   'price': priceValue,
    //   'image': 'assets/barbell.jpg'
    // };
    if (widget.product == null)
      widget.addProduct(_formData);
    else
      widget.updatePorduct(widget.productIndex, _formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = this._buildPageContent(context);
    if (widget.product == null) return pageContent;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: pageContent,
    );
  }
}
