import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusNode = FocusNode();
  final _discriptionFocusNode  = FocusNode();


  @override
  void dispose() {
    _pricefocusNode.dispose();
    _discriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Form(
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_pricefocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price ',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _pricefocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_discriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _discriptionFocusNode,
            ),
          ],
        )),
      ),
    );
  }
}
