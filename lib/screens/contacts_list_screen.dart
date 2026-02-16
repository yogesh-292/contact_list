import 'package:flutter_practice/core/app_imports.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Obx(() {
      if (userController.loading.value) {
        return const Center(child: CircularProgressIndicator(color: Colors.black38));
      }

      if (userController.error.value != null) {
        return Center(
          child: Text(userController.error.value!, style: const TextStyle(color: Colors.red)),
        );
      }

      if (userController.users.isEmpty) {
        return const Center(
          child: Text('No contacts found', style: TextStyle(color: Colors.red)),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          userController.fetchUsers();
        },
        child: ListView.separated(
          itemCount: userController.users.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final user = userController.users[index];

            return ListTile(
              onTap: () {
                Get.to(() => ContactDetailsScreen(user: user));
              },
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(192, 43, 43, 42),
                child: Text(user.initials, style: const TextStyle(color: Colors.white)),
              ),
              title: Text(user.name),
              subtitle: Text(user.phone),
              trailing: Icon(Icons.navigate_next),
            );
          },
        ),
      );
    });
  }
}
