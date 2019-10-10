import 'dart:convert';

import 'package:flutteress/models/product.dart';
import 'package:flutteress/scoped-models/connected_scopes.dart';
import 'package:http/http.dart' as http;

class ProductsModel extends ConnectedScopes {
  bool showFavourites = false;

  List<Product> get products {
    return List.from(c_products);
  }

  bool get isLoading {
    return c_isLoading;
  }

  int get selectedProductIndex {
    return c_products.indexWhere((Product product) {
      return product.id == c_selectedProductID;
    });
  }

  List<Product> get displayedProducts {
    if (showFavourites) {
      return List.from(
          c_products.where((Product product) => product.isFavourite).toList());
    }
    return List.from(c_products);
  }

  String get selectedProductID {
    return c_selectedProductID;
  }

  Product get selectedProduct {
    if (c_selectedProductID == null) return null;
    return c_products.firstWhere((product) {
      return product.id == c_selectedProductID;
    });
  }

  Future<bool> deleteProduct() {
    c_isLoading = true;
    final productID = selectedProduct.id;
    c_products.removeAt(selectedProductIndex);
    c_selectedProductID = null;
    notifyListeners();
    return http
        .delete('https://flutteress.firebaseio.com/products/${productID}.json?auth=${c_authenticatedUser.token}')
        .then((http.Response response) {
      c_isLoading = false;
      notifyListeners();
      return true;
    }).catchError((onError) {
      c_isLoading = false;
      notifyListeners();
      return false;
    });
    // c_products.removeAt(c_selectedProductIndex);
    // c_selectedProductIndex = null;
  }

  Future<bool> updateProduct(
      String title, String description, double price, String image) {
    c_isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/12/06/09/chocolate-holding.jpg?w968h681',
      'userEmail': c_authenticatedUser.email,
      'userId': c_authenticatedUser.id
    };
    return http
        .put(
            'https://flutteress.firebaseio.com/products/${selectedProduct.id}.json?auth=${c_authenticatedUser.token}',
            body: json.encode(updateData))
        .then((http.Response response) {
      final Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          price: price,
          image: image,
          email: selectedProduct.email,
          userId: selectedProduct.userId);
      c_products[selectedProductIndex] = updatedProduct;
      notifyListeners();
      return true;
    }).catchError((onError) {
      c_isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchProducts() {
    c_isLoading = true;
    notifyListeners();
    
    return http
        .get('https://flutteress.firebaseio.com/products.json?auth=${c_authenticatedUser.token}')
        .then<Null>((http.Response res) {
      final List<Product> productList = [];
      c_products=[];
      final Map<String, dynamic> productListData = json.decode(res.body);
      c_isLoading = false;
      if (productListData == null) {
        c_isLoading = false;
        notifyListeners();
        return;
      }
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
      c_selectedProductID = null;
    }).catchError((onError) {
      c_isLoading = false;
      notifyListeners();
      return null;
    });
  }

  void selectProduct(String productId) {
    c_selectedProductID = productId;
    notifyListeners();
  }

  void toggleFavouriteStatus(String productId) {
    final bool isCurrentlyFavourite =
        c_products[selectedProductIndex].isFavourite;
    final bool newFavStatus = !isCurrentlyFavourite;
    final Product selectedProduct = c_products[selectedProductIndex];
    Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        isFavourite: newFavStatus,
        email: selectedProduct.email,
        userId: selectedProduct.userId,
        image: selectedProduct.image);
    c_products[selectedProductIndex] = updatedProduct;
    c_selectedProductID = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    showFavourites = !showFavourites;
    notifyListeners();
  }
}
