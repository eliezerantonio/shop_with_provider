import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:gerencimento_estado/helpers/app_routes.dart';
import 'package:gerencimento_estado/providers/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.title,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCTFORM, arguments: product);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Tem certeza?"),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Nao"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Sim"),
                          ),
                        ],
                      );
                    }).then((value) => {
                      if (value)
                        {
                          Provider.of<Products>(context, listen: false)
                              .deleteProduct(product.id)
                        }
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
