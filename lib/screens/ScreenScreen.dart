import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:gerencimento_estado/screens/ProductScreen.dart';
import 'package:gerencimento_estado/screens/cart_screen.dart';
import 'package:gerencimento_estado/screens/home_screen.dart';
import 'package:gerencimento_estado/screens/orders_screen.dart';
import 'package:gerencimento_estado/screens/product_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            CartScreen(),
            OrderScreen(),
            ProductScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
              activeColor: Colors.purple),
          BottomNavyBarItem(
              title: Text('Carrinho'),
              icon: Icon(Icons.shopping_cart),
              activeColor: Colors.purple),
          BottomNavyBarItem(
              title: Text('Pedidos'),
              icon: Icon(Icons.list),
              activeColor: Colors.purple),
          BottomNavyBarItem(
              title: Text('Produtos'),
              icon: Icon(Icons.paste_rounded),
              activeColor: Colors.purple),
        ],
      ),
    );
  }
}
