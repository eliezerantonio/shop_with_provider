import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/product.dart';
import 'package:gerencimento_estado/providers/counter_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product proudct =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(proudct.title),
        // ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              proudct.title,
            ),
            background: Hero(
              tag: proudct.id,
              child: Image.network(
                proudct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Text(
              "AOA ${proudct.price}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                proudct.description,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 800,
            )
          ]),
        )
      ],
    ));
  }
}
