import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:gerencimento_estado/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _url =
      "https://fluttercoder-15a98-default-rtdb.firebaseio.com/products.json";
  List<Product> _items = [];

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
  Future<void> addProduct(Product newProduct) async {
    try {
      final response = await http.post(_url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
            'imageUrl': newProduct.imageUrl,
          }));
      _items.add(Product(
        id: json.decode(response.body)['name'],
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        title: newProduct.title,
      ));
      notifyListeners();
    } catch (e) {}
  }

  Future<void> loadProducts() async {
    final response = await http.get(_url);

    Map<String, dynamic> data = json.decode(response.body);

    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        description: productData['description'],
        imageUrl: productData['imageUrl'],
        price: productData['price'],
        title: productData['title'],
        isFavorite: productData['isFavorite'],
      ));
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
