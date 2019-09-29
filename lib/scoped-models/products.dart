import 'dart:convert';

import 'package:flutteress/models/product.dart';
import 'package:flutteress/scoped-models/connected_scopes.dart';
import 'package:http/http.dart' as http;

class ProductsModel extends ConnectedScopes {
  bool showFavourites = false;

  List<Product> get products {
    return List.from(c_products);
  }

  List<Product> get displayedProducts {
    if (showFavourites) {
      return List.from(
          c_products.where((Product product) => product.isFavourite).toList());
    }
    return List.from(c_products);
  }

  int get selectedProductIndex {
    return c_selectedProductIndex;
  }

  Product get selectedProduct {
    if (c_selectedProductIndex == null) return null;
    return c_products[c_selectedProductIndex];
  }

  void deleteProduct() {
    c_products.removeAt(c_selectedProductIndex);
    c_selectedProductIndex = null;
  }

  void updateProduct(
      String title, String description, double price, String image) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        email: selectedProduct.email,
        userId: selectedProduct.userId);

    c_products[c_selectedProductIndex] = updatedProduct;
    c_selectedProductIndex = null;
  }

  void fetchProducts() {
    http
        .get('https://flutteress.firebaseio.com/products.json')
        .then((http.Response res) {
      final List<Product> productList = [];
      final Map<String, dynamic> productListData = json.decode(res.body);
      
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userId: productData['userId'],
            email: productData['userEmail']);
        productList.add(product);
      });

      // print(productList.toList());
      c_products = productList;
      notifyListeners();
    });
  }

  void selectProduct(int index) {
    c_selectedProductIndex = index;
  }

  void toggleFavouriteStatus(int index) {
    final bool isCurrentlyFavourite = c_products[index].isFavourite;
    final bool newFavStatus = !isCurrentlyFavourite;
    final Product selectedProduct = c_products[index];
    Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        isFavourite: newFavStatus,
        email: selectedProduct.email,
        userId: selectedProduct.userId,
        image: selectedProduct.image);
    c_products[index] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavourites = !showFavourites;
    notifyListeners();
  }
}
