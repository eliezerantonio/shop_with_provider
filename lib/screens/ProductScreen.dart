import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/product_item.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/products.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = context.watch<Products>();
    final products = productsData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTFORM);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: productsData.itemCount(),
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                ProductItem(products[i]),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
