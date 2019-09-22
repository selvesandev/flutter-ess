import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String priceTag;
  PriceTag(this.priceTag);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        '\$$priceTag',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
