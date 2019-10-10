import 'package:flutter/material.dart';
import 'package:flutteress/pages/product_create.dart';
import 'package:flutteress/pages/product_list.dart';
import 'package:flutteress/scoped-models/main.dart';
import 'package:flutteress/widgets/ui_element/log_out_list_tile.dart';

class ProductAdmin extends StatelessWidget {
  final MainModel mainModel;
  ProductAdmin(this.mainModel);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(automaticallyImplyLeading: false, title: Text('Choose')),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('All Product'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/products');
              }),
          Divider(),
          LogoutListTile()
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
          children: <Widget>[ProductCreate(), ProductListPage(mainModel)],
        ),
      ),
    );
  }
}
