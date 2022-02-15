import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const UserProductItem({ this.imageUrl, this.title}) ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon:const  Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
