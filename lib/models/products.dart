import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorit;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    this.isFavorit,
    @required this.price,
  });

  void toggleFavorite() {
    isFavorit = !isFavorit;
    notifyListeners();
  }
}
