import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/payment_page.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> item;
  final String username;
  final String userEmail;

  const ProductDetails({
    Key? key,
    required this.item,
    required this.username,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              item['image'],
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${item['description']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${item['price']} Tk',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: implement add to cart functionality
                    },
                    child: Text('Add to Cart'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to the payment page
                      final address = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            username: username,
                            productName: item['name'],
                          ),
                        ),
                      );

                      if (address != null) {
                        // Add order to Firestore
                        final order = {
                          'username': username,
                          'product_name': item['name'],
                          'address': address,
                          'timestamp': DateTime.now().millisecondsSinceEpoch,
                        };
                        FirebaseFirestore.instance
                            .collection('order_history')
                            .add(order)
                            .then((value) => print('Order added'))
                            .catchError((error) => print('Failed to add order: $error'));
                      }
                    },
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
