import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:gerencimento_estado/data/dummy_data.dart';
import 'package:gerencimento_estado/providers/product.dart';
import 'package:http/http.dart' as http;

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
    const url =
        "https://fluttercoder-15a98-default-rtdb.firebaseio.com/products.json";

    http
        .post(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price,
              'isFavorite': newProduct.isFavorite,
              'imageUrl': newProduct.imageUrl,
            }))
        .then((response) {

      _items.add(Product(
        id: json.decode(response.body)['name'],
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
      ));
      notifyListeners();
    });
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

  void deleteProduct(String id) {
    if (id != null) {
      final index = _items.indexWhere((prod) => prod.id == id);
      if (index >= 0) {
        _items.removeWhere((prod) => prod.id == id);
        notifyListeners();
      }
    }
  }
}
