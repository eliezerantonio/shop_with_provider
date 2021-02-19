import 'package:flutter/material.dart';
import 'package:gerencimento_estado/components/order_widget.dart';
import 'package:gerencimento_estado/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:gerencimento_estado/components/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = context.watch<Orders>();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, i) {
          return OrderWidget(orders.items[i]);
        },
      ),
    );
  }
}
