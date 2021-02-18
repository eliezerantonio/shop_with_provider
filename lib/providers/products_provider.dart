import 'package:flutter/widgets.dart';
import 'package:gerencimento_estado/data/dummy_data.dart';
import 'package:gerencimento_estado/models/products.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

// retornando uma copia com o Spread
  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
