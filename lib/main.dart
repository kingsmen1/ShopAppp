import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:shopapp/screens/splash_screen.dart';
import '../providers/auth.dart';
import '../screens/auth_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/orders.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import './screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(null, null, []),
            update: (_, auth, prevProducts) =>
                Products(
                  auth.token,
                  auth.userId,
                  prevProducts.items,
                ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders(null, null, []),
              update: (_, auth, prevOrders) =>
                  Orders(auth.token, auth.userId, prevOrders.orders)),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            ifAuth(targetScreen) => auth.isAuth ? targetScreen : AuthScreen();
            return MaterialApp(
                title: 'MyShop',
                theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato',
                ),
                home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder:(ctx, authResultSnapshot)=> authResultSnapshot
                  .connectionState == ConnectionState.waiting ?  SplashScreen() :AuthScreen(),
                  ) ,
            // initialRoute: '/',
            routes: {
            ProductDetailScreen.routeName: (ctx) => ifAuth(ProductDetailScreen()),
            CartScreen.routeName: (ctx) => ifAuth(CartScreen()),
            OrdersScreen.routeName: (ctx) =>ifAuth(OrdersScreen()) ,
            UserProductsScreen.routeName: (ctx) =>ifAuth(UserProductsScreen()),
            EditProductScreen.routeName: (ctx) => ifAuth(EditProductScreen()),
            });
          },
        ));
  }
}
