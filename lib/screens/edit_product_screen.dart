import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    title: '',
    price: 0,
    id: null,
    imageUrl: '',
    description: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
    }
    setState(() {});
  }

  void _saveForm() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.id);
    print(_editedProduct.imageUrl);
    print(_editedProduct.description);
  }

  @override
  void dispose() {
    _pricefocusNode.dispose();
    _imageUrlController.removeListener(() {});
    _discriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: Form(
        key: _form,
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Provide a value';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                    title: value,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    price: _editedProduct.price);
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the Amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a Valid Amount';
                }
                if (double.parse(value) <= 0) {
                  return 'Price Should be more than 1\$';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    price: double.parse(value));
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _discriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter the Discription';
                }
                if (value.length < 10) {
                  return 'Should be atleast 10 Charecters long';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                    title: _editedProduct.title,
                    description: value,
                    imageUrl: _editedProduct.imageUrl,
                    id: _editedProduct.id,
                    price: _editedProduct.price);
              },
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
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter Image Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          )),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image Url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    /*onChanged: (value) {
                      setState(() {
                        _imageUrl = value;
                      });
                    },*/
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter the image URL';
                      }
                      if (!value.startsWith('http') &&
                          !value.startsWith('https')) {
                        return 'Enter a Valid URL';
                      }
                      if (!value.endsWith('.png') &&
                          !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
                        return 'Enter a Valid URL';
                      }
                      return null;
                    },
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          imageUrl: value,
                          id: _editedProduct.id,
                          price: _editedProduct.price);
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
