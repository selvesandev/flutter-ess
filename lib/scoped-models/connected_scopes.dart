import 'dart:convert';

import 'package:flutteress/models/product.dart';
import 'package:flutteress/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ConnectedScopes extends Model {
  List<Product> c_products = [];
  User c_authenticatedUser;
  String c_selectedProductID;
  bool c_isLoading = false;

  Future<bool> addProduct(
      String title, String description, double price, String image) async {
    c_isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/12/06/09/chocolate-holding.jpg?w968h681',
      'userEmail': c_authenticatedUser.email,
      'userId': c_authenticatedUser.id
    };

    try {
      final http.Response response = await http.post(
          'https://flutteress.firebaseio.com/products.json',
          body: json.encode(productData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        c_isLoading = false;
        notifyListeners();
        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);

      final Product product = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          email: c_authenticatedUser.email,
          userId: c_authenticatedUser.id);
      c_products.add(product);
      c_selectedProductID = null;
      c_isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      c_isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
