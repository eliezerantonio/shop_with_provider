import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gerencimento_estado/providers/orders.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  OrderWidget(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
        title: Text("AOA ${order.total}"),
        subtitle: Text(DateFormat('dd-MM-yyyy hh:mm').format(order.date)),
      ),
    );
  }
}
