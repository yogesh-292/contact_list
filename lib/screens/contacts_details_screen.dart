import 'package:flutter_practice/core/app_imports.dart';

class ContactDetailsScreen extends StatefulWidget {
  final User user;

  const ContactDetailsScreen({super.key, required this.user});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 80),

            /// Avatar
            /// Todo:in future the image of the
            /// user will be displayed here
            CircleAvatar(
              radius: 52,
              backgroundColor: const Color.fromARGB(192, 43, 43, 42),
              child: Text(
                widget.user.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 26),

            // Details Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InfoRow(label: "Name", value: widget.user.name),
                  const AppDivider(height: 20),
                  InfoRow(label: "Username", value: widget.user.username),
                  const AppDivider(height: 20),
                  InfoRow(label: "Phone", value: widget.user.phone),
                  const AppDivider(height: 20),
                  InfoRow(label: "Website", value: widget.user.website),
                  const AppDivider(height: 20),
                  InfoRow(label: "Address", value: widget.user.address.fullAddress),
                  const AppDivider(height: 20),
                  InfoRow(
                    label: "Catch Phrase",
                    value: widget.user.company.catchPhrase,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  Get.to(() => Screen3());
                },
                child: Text("Screen 3"))
          ],
        ),
      ),
    );
  }
}
