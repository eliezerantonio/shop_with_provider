import 'package:flutter/material.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/counter_provider.dart';
import 'package:gerencimento_estado/providers/products_provider.dart';
import 'package:gerencimento_estado/screens/product_detail_screen.dart';
import 'package:gerencimento_estado/screens/products_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange, 
          fontFamily: 'Lato',
        ),
        home: ProductsScreen(),
        routes: {AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}
