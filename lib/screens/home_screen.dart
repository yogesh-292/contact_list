import 'package:flutter/material.dart';
import './contacts_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: const ContactsListScreen(),
    );
  }
}
