import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  String _imageUrl = "";
  final _imageUrlFocusNode = FocusNode();

 /* @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    setState(() {});
  }*/

  @override
  void dispose() {
    _pricefocusNode.dispose();
    _discriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.dispose();
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
              onFieldSubmitted: (_) {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child:   _imageUrl.isEmpty
                        ? Text('Enter Image Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image Url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _imageUrl = value;
                      });
                    },
                    //controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onEditingComplete: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
