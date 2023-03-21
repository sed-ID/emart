import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

  String _itemName = '';
  String _itemCategory = '';
  String _itemDescription = '';
  double _itemPrice = 0.0;
  String _itemImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Item Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Item Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemCategory = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Item Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemDescription = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Item Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemPrice = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Item Image URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemImageUrl = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await FirebaseFirestore.instance.collection('items').add({
                        'name': _itemName,
                        'category': _itemCategory,
                        'description': _itemDescription,
                        'price': _itemPrice,
                        'image': _itemImageUrl,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Item added successfully')),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}