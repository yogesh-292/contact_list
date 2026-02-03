import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Obx(() {
      if (controller.loading.value) {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black38,
        ));
      }

      if (controller.error.value != null) {
        return Center(
          child: Text(
            controller.error.value!,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      if (controller.users.isEmpty) {
        return const Center(
            child: Text(
          'No contacts found',
          style: TextStyle(color: Colors.red),
        ));
      }

      return RefreshIndicator(
        onRefresh: () async {
          controller.fetchUsers();
        },
        child: ListView.separated(
          itemCount: controller.users.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final user = controller.users[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(192, 43, 43, 42),
                child: Text(
                  user.initials,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.phone),
            );
          },
        ),
      );
    });
  }
}
