import 'package:flutter/material.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/auth.dart';
import 'package:gerencimento_estado/providers/cart.dart';
import 'package:gerencimento_estado/providers/counter_provider.dart';
import 'package:gerencimento_estado/providers/products.dart';
import 'package:gerencimento_estado/screens/ScreenScreen.dart';
import 'package:gerencimento_estado/screens/auth_home.dart';
import 'package:gerencimento_estado/screens/auth_screen.dart';
import 'package:gerencimento_estado/screens/cart_screen.dart';
import 'package:gerencimento_estado/screens/orders_screen.dart';
import 'package:gerencimento_estado/screens/product_detail_screen.dart';
import 'package:gerencimento_estado/screens/home_screen.dart';
import 'package:gerencimento_estado/screens/product_form_screen.dart';
import 'package:provider/provider.dart';

import 'providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => new Products(),
          update: (ctx, auth, previousProducts) => new Products(
            auth.token,
            auth.userId,
            previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => new Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => new Orders(),
          update: (ctx, auth, previousOrders) => new Orders(
            auth.token,
            auth.userId,
            previousOrders.items,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        // initialRoute: AppRoutes.AUTH_HOME,
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrderScreen(),
          AppRoutes.HOME: (ctx) => HomeScreen(),
          AppRoutes.PRODUCTFORM: (ctx) => ProductFormScreen(),
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.MAIN: (ctx) => MainScreen(),
        },
      ),
    );
  }
}
