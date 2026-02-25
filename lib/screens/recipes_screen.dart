import 'package:flutter_practice/core/app_imports.dart';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({super.key});

  /// Inject controller
  final RecipesController controller = Get.put(RecipesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipes"), centerTitle: true),
      body: Obx(() {
        ///  Show error if exists
        if (controller.error.value != null) {
          return Center(
            child: Text(controller.error.value!, style: const TextStyle(color: Colors.red)),
          );
        }

        ///  If list is empty (still loading or no data)
        if (controller.recipes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        ///  Show Recipes List
        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchRecipes();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.recipes.length,
            itemBuilder: (context, index) {
              final Recipe recipe = controller.recipes[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///  Recipe Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(recipe.image, height: 180, width: double.infinity, fit: BoxFit.cover),
                    ),

                    ///  Recipe Details
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recipe.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber.shade600, size: 18),
                              const SizedBox(width: 4),
                              Text(recipe.rating.toString(), style: const TextStyle(fontSize: 14)),
                              const Spacer(),
                              Text(
                                recipe.difficulty,
                                style: TextStyle(
                                  color: recipe.difficulty == "Easy"
                                      ? Colors.green
                                      : recipe.difficulty == "Medium"
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "${recipe.prepTimeMinutes + recipe.cookTimeMinutes} mins • ${recipe.cuisine}",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
