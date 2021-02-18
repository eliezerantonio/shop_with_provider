import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/product_item.dart';
import 'package:gerencimento_estado/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.items;
    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (cxt, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
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
    );
  }
}
