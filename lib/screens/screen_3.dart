import 'package:flutter_practice/core/app_imports.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    RxString displayText = ''.obs;
    RxString displayText2 = ''.obs;
    RxString passwordText = ''.obs;

    return Scaffold(
      appBar: AppBar(title: Text("Screen 3"), backgroundColor: Colors.grey),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                  labelText: "First Name", hintText: "Enter your first name", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                  labelText: "Last Name", hintText: "Enter your last name", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "password", hintText: "Enter your password", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                displayText.value = firstNameController.text;
                displayText2.value = lastNameController.text;
                passwordText.value = passwordController.text;
              },
              child: Text("Submit")),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Get.to(() => QuotesScreen());
              },
              child: Text("Screen 4"))
        ],
      )),
    );
  }
}
