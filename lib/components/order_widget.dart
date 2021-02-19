import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gerencimento_estado/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  OrderWidget(this.order);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
            title: Text("AOA ${widget.order.total.toStringAsFixed(2)}"),
            subtitle:
                Text(DateFormat('dd-MM-yyyy hh:mm').format(widget.order.date)),
          ),
          if (_expanded)
            Container(
                height: widget.order.products.length * 25.0 + 10,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: ListView(
                  children: widget.order.products.map((product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${product.quantity} x AOA ${product.price}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    );
                  }).toList(),
                ))
        ],
      ),
    );
  }
}
