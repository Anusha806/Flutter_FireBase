import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitPage extends StatefulWidget {
  final String name;
  final String id;
  final String email;

  const SubmitPage({Key? key, required this.name, required this.id, required this.email}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${widget.name}'),
            Text('ID: ${widget.id}'),
            Text('Email: ${widget.email}'),
            ElevatedButton(
              onPressed: () => _insertData(widget.name, widget.id, widget.email),
              child: Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }

  void _insertData(String name, String id, String email) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'id': id,
        'email': email,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data inserted successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error inserting data: $e'),
        ),
      );
    }
  }
}
