import 'package:flutter_practice/core/app_imports.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts"), centerTitle: true),

      body: ContactsListScreen(),
    );
  }
}
