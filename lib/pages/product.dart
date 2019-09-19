import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title, image, description;
  // final String imageUrl;

  ProductPage(this.title, this.image,this.description);

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
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(image),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(title),
                      ),
                      Center(
                        child: Text(description,),
                      )
                    ],
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Delete'),
                  onPressed: () => _showWarnindDialog(context),
                ),
              ),
            ]),
      ),
    );
  }
}
