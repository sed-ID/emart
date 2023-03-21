import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> item;

  const ProductDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              item['image'],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 8),
                Text(
                  '${item['price']} EGP',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 8),
                Text(
                  item['description'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement add to cart functionality
              },
              child: Text('Add to cart'),
            ),
          ),
        ],
      ),
    );
  }
}