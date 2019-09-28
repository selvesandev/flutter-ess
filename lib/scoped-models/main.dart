import 'package:flutteress/scoped-models/connected_scopes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'products.dart';
import 'user.dart';

class MainModel extends Model with ConnectedScopes, UserModal, ProductsModel {}
