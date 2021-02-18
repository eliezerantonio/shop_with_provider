import 'package:flutter/material.dart';
import 'package:gerencimento_estado/models/products.dart';
import 'package:gerencimento_estado/providers/counter_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product proudct =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(proudct.title),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
