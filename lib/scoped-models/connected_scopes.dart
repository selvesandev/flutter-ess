import 'package:flutteress/models/product.dart';
import 'package:flutteress/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedScopes extends Model {
  List<Product> c_products = [];
  User c_authenticatedUser;
  int c_selectedProductIndex;

  void addProduct(
      String title, String description, double price, String image) {
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
