import 'dart:convert';

import 'package:flutteress/models/product.dart';
import 'package:flutteress/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ConnectedScopes extends Model {
  List<Product> c_products = [];
  User c_authenticatedUser;
  int c_selectedProductIndex;

  void addProduct(
      String title, String description, double price, String image) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/12/06/09/chocolate-holding.jpg?w968h681'
    };
    http
        .post('https://flutteress.firebaseio.com/products.json',
            body: json.encode(productData))
        .catchError((onError) {
      print(onError);
    });

    final Product product = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        email: c_authenticatedUser.email,
        userId: c_authenticatedUser.id);
    c_products.add(product);
    c_selectedProductIndex = null;
  }
}
