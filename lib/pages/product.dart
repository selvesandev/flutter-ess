import 'package:flutter/material.dart';
import 'package:flutteress/models/product.dart';
import 'dart:async';

import 'package:flutteress/widgets/ui_element/title_default.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  // final String imageUrl;

  ProductPage(this.product);

  _showWarnindDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('This action cannot be undone.'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      Navigator.pop(context, false);
      return Future.value(false);
    }, child:  Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(product.image),
                  placeholder: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                  height: 300,
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: TitleDefault(product.title),
                        ),
                        Center(
                          child: Text(
                            product.description,
                          ),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _showWarnindDialog(context),
                  ),
                ),
              ]),
        ));
      
  }
}
