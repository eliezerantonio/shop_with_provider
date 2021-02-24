import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gerencimento_estado/providers/product.dart';

class ProductFormScreen extends StatefulWidget {
  ProductFormScreen({Key key}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  void _updateImageUrl() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
  }

  void _saveForm() {
    _form.currentState.save();
    final newProduct = Product(
        id: Random().nextDouble().toString(),
        title: _formData['title'],
        price: _formData['price'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario Produto"),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt_outlined),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Titulo",
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
                onSaved: (value) => _formData['title'] = value,
              ),
              TextFormField(
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "Preco",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) => _formData['price'] = double.parse(value),
              ),
              TextFormField(
                focusNode: _descriptionFocusNode,
                decoration: InputDecoration(
                  labelText: "Descricao",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) =>
                    _formData['description'] = double.parse(value),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      decoration: InputDecoration(labelText: "URL da imagem"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) => _formData['imageUrl'] = value,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text("Informe a URL")
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
