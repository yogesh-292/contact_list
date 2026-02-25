import 'package:flutter_practice/core/app_imports.dart';
import 'package:flutter_practice/screens/cart_screen.dart';
import 'package:flutter_practice/screens/contacts_screen.dart';

/// ------------------------------------------------------------
/// HomeScreen
/// ------------------------------------------------------------
/// This screen acts as the main entry menu of the application.
///
/// It provides navigation buttons to different feature screens:
/// - Product Screen
/// - Quotes Screen
/// - Contact Screen
/// - Carts Screen
///
/// Navigation is handled using GetX (`Get.to()`).
/// ------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Debug print to inspect the current BuildContext.
    /// Useful during development for understanding widget tree behavior.
    debugPrint('the context for the home screen is -----> $context');

    return Scaffold(
      /// Light background color for the entire screen
      backgroundColor: const Color.fromARGB(243, 249, 247, 247),

      /// Top AppBar displaying screen title
      appBar: AppBar(
        title: const Text('Main Menu'),
        centerTitle: true,

        /// Semi-transparent black background
        backgroundColor: Colors.black.withAlpha(90),
      ),

      /// Body contains centered menu buttons
      body: Center(
        child: Column(
          /// Align buttons vertically in the center
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            /// Navigates to Product Screen
            MenuButton(title: "Product Screen", onTap: () => Get.to(() => ProductScreen())),

            /// Spacing between buttons
            const SizedBox(height: 20),

            /// Navigates to Quotes Screen
            MenuButton(title: "Quotes Screen", onTap: () => Get.to(() => QuotesScreen())),

            const SizedBox(height: 20),

            /// Navigates to Contacts Screen
            MenuButton(title: "Contact Screen", onTap: () => Get.to(() => ContactsScreen())),

            const SizedBox(height: 20),

            /// Navigates to Cart Screen
            MenuButton(title: "   Carts Screen  ", onTap: () => Get.to(() => CartPage())),

            const SizedBox(height: 20),

            /// Navigates to Recipies Screen
            MenuButton(title: "Recipes Screen", onTap: () => Get.to(() => RecipesScreen())),
          ],
        ),
      ),
    );
  }
}
