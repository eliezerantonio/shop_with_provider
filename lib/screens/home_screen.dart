import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/app_drawer.dart';
import 'package:gerencimento_estado/components/badge.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/cart.dart';
import 'package:gerencimento_estado/providers/products.dart';
import '../components/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    //carregar prorodutos

    Provider.of<Products>(context, listen: false).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("My Shop"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorite) {
                setState(() {
                  _showFavoriteOnly = true;
                });
              } else {
                setState(() {
                  _showFavoriteOnly = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, __) {
              return Badge(
                value: cart.itemsCount.toString(),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.CART);
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_showFavoriteOnly),
    );
  }
}
