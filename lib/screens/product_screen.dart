import 'package:flutter_practice/core/app_imports.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Products"), backgroundColor: Colors.grey),
      body: Obx(() {
        // Loader (from BaseController)
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.grey));
        }

        // Error state
        if (controller.error.value != null) {
          return Center(
            child: Text(controller.error.value!, style: const TextStyle(color: Colors.red)),
          );
        }

        // Empty state
        if (controller.products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        // Products list
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final product = controller.products[index];

            return Card(
              elevation: 2,
              child: ListTile(
                leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(product.title),
                subtitle: Text('₹ ${product.price}', style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: Icon(
                  product.inStock ? Icons.check_circle : Icons.remove_circle,
                  color: product.inStock ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
