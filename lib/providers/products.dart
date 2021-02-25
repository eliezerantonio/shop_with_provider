import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:gerencimento_estado/data/dummy_data.dart';
import 'package:gerencimento_estado/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

// retornando uma copia com o Spread
  List<Product> get items => [..._items];
  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  int itemCount() {
    return _items.length;
  }

  /* 
  bool _showFavoriteOnly = false;
  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }
  void showAll(){
    _showFavoriteOnly-false;
    notifyListeners();
  }
*/
  void addProduct(Product newProduct) {
    _items.add(Product(
      id: Random().nextDouble().toString(),
      description: newProduct.description,
      imageUrl: newProduct.imageUrl,
      price: newProduct.price,
      title: newProduct.title,
    ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

}
