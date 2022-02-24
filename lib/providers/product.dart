import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';



class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  void _changeIsFavorite (value){
    isFavorite = value;
    notifyListeners();
  }
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.parse(
        "https://flutter-update-4c020-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json");
    bool oldStatus = isFavorite;
    _changeIsFavorite(!isFavorite);
    // try {
      final response = await http.patch(url,
          body: jsonEncode({
            "isFavorite": isFavorite,
          }));
      if (response.statusCode >= 400) {
        _changeIsFavorite(oldStatus);
        throw HttpException('Could Not Favorite');
      }
    } //catch (error) {
    //   _changeIsFavorite(oldStatus);
    // }
  }
// }
