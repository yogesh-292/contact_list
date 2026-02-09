import 'package:flutter_practice/core/app_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        backgroundColor: Colors.black.withAlpha(80),
      ),
      body: const ContactsListScreen(),
    );
  }
}
