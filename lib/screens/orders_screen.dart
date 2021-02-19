import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
    );
  }
}
