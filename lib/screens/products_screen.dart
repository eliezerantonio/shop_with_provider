import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/product_item.dart';
import 'package:gerencimento_estado/models/products.dart';
import '../data/dummy_data.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: loadedProducts.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (cxt, i) => ProductItem(loadedProducts[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //quantidade de colunas
          crossAxisCount: 2,
          //altura e largura
          childAspectRatio: 3 / 2,
          //espacamento no eixo cruzado
          crossAxisSpacing: 10,
          //espacamento no main
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
