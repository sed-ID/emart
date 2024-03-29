import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to print out who is signed in
  final user = FirebaseAuth.instance.currentUser!;
  String _username = '';

  // fetch the username from Firestore
  Future<void> _fetchUsername() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('users').get();
    if (snapshot.docs.isNotEmpty) {
      _username = snapshot.docs.first.data()['username'];
    }
    setState(() {}); // rebuild the UI after fetching the username
  }

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_username),
              accountEmail: Text(user.email ?? ''),
              currentAccountPicture: CircleAvatar(
                child: Text(_username.isNotEmpty ? _username[0] : '',
                    style: TextStyle(fontSize: 28)),
              ),
            ),
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.requireData;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: data.size,
            itemBuilder: (context, index) {
              final item = data.docs[index];

              return InkWell(
                onTap: () {
                  // TODO: Navigate to product details page
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          item['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        title: Text(item['name']),
                        subtitle: Text('${item['price']} EGP'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
