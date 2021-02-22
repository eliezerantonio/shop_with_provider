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
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
