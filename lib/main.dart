import 'package:flutter/material.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/cart.dart';
import 'package:gerencimento_estado/providers/counter_provider.dart';
import 'package:gerencimento_estado/providers/products.dart';
import 'package:gerencimento_estado/screens/cart_screen.dart';
import 'package:gerencimento_estado/screens/orders_screen.dart';
import 'package:gerencimento_estado/screens/product_detail_screen.dart';
import 'package:gerencimento_estado/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: HomeScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrderScreen(),
          AppRoutes.HOME: (ctx) => HomeScreen()
        },
      ),
    );
  }
}
