import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gerencimento_estado/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _baseUrl =
      "https://fluttercoder-15a98-default-rtdb.firebaseio.com/products";
  List<Product> _items = [];
  String _token;
  Products(this._token, this._items);
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
      final response = await http.post("$_baseUrl.json?auth=$_token",
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
    final response = await http.get("$_baseUrl.json?auth=$_token");

    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      _items.clear();
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
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      await http.patch("$_baseUrl/${product.id}.json?auth=$_token",
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            //'isFavorite': product.isFavorite,
            'imageUrl': product.imageUrl,
          }));

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    if (id != null) {
      final index = _items.indexWhere((prod) => prod.id == id);
      if (index >= 0) {
        final product = _items[index];
        _items.remove(product);
        notifyListeners();
        final response = await http.delete("$_baseUrl/${product.id}.json?auth=$_token");

        if (response.statusCode >= 400) {
          _items.insert(index, product);
          notifyListeners();
        }
      }
    }
  }
}
