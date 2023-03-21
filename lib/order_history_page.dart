import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderHistoryScreen({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders found.'))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(order['product_name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order['address']),
                  SizedBox(height: 5),
                  Text(
                    'Ordered on: ${order['timestamp'].toDate()}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}