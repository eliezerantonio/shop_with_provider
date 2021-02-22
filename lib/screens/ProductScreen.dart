import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/products.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Products>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: products.itemCount(),
          itemBuilder: (ctx, i) {
            return Text("Eliezer");
          },
        ),
      ),
    );
  }
}
