import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/products.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              )
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString()),
          child:Icon(Icons.shopping_cart) ,)
        ],
        title: const Text('MyShop'),
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
