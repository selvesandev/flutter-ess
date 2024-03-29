import 'package:flutter/material.dart';
import 'package:flutteress/models/product.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCreate extends StatefulWidget {
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

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      autofocus: true,
      initialValue: product == null ? '' : product.title,
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
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
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

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      initialValue: product == null ? '' : product.price.toString(),
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

  _onFormSubmit(
      Function addProduct, Function updateProduct, Function selectProduct,
      [int selectedProductIndex]) {
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
    if (selectedProductIndex == -1)
      addProduct(_formData['title'], _formData['description'],
              _formData['price'], _formData['image'])
          .then((bool success) {
        if (success)
          Navigator.pushReplacementNamed(context, '/products').then((_) {
            selectProduct(null);
          });
        else
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
      });
    else
      updateProduct(_formData['title'], _formData['description'],
              _formData['price'], _formData['image'])
          .then((_) {
        Navigator.pushReplacementNamed(context, '/products').then((_) {
          selectProduct(null);
        });
      });
  }

  Widget _buildSubmitBtn() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : (RaisedButton(
                child: Text('Save'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () => _onFormSubmit(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              ));
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product selectedProduct) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
// print(selectedProduct);
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
              _buildTitleTextField(selectedProduct),
              _buildDescriptionTextField(selectedProduct),
              _buildPriceTextField(selectedProduct),
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
              _buildSubmitBtn()
              // GestureDetector(
              //   onTap: _onFormSubmit,
              //   child: Container(
              //     child: Text('Guesture'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            this._buildPageContent(context, model.selectedProduct);
        print(model.selectedProduct.toString());
        return (model.selectedProductIndex == -1)
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
