import 'package:flutter/material.dart';
import '../components/product_grid.dart';


class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        centerTitle: true,
      ),
      body: ProductGrid(),
    );
  }
}