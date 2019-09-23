import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';
import 'package:flutteress/pages/product_list.dart';

class ProductAdmin extends StatelessWidget {
  final Function deleteProduct;
  final Function addProduct;
  final Function updateProduct;
  final List<Map<String, dynamic>> products;

  ProductAdmin(
      this.addProduct, this.deleteProduct, this.products, this.updateProduct);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(automaticallyImplyLeading: false, title: Text('Choose')),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('All Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/products');
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Product'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Create Product',
                icon: Icon(Icons.create),
              ),
              Tab(
                text: 'My Products',
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductCreate(
              addProduct: addProduct,
            ),
            ProductList(this.products, this.updateProduct)
          ],
        ),
      ),
    );
  }
}
