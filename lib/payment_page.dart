import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String username;
  final String productName;

  const PaymentPage({
    Key? key,
    required this.username,
    required this.productName,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Return address to the previous page
                Navigator.pop(context, _addressController.text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // You can perform any initialization here if needed
  }
}