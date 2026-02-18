import 'package:flutter_practice/core/app_imports.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carts")),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.carts.isEmpty) {
          return const Center(child: Text("No carts found"));
        }

        return ListView.builder(
          itemCount: controller.carts.length,
          itemBuilder: (context, index) {
            final cart = controller.carts[index];

            return Card(
              child: ExpansionTile(
                title: Text("Cart ID: ${cart.id}"),
                subtitle: Text("Total: \$${cart.discountedTotal}"),
                children: cart.products.map((product) {
                  return ListTile(
                    leading: Image.network(product.thumbnail, width: 50),
                    title: Text(product.title),
                    subtitle: Text("Qty: ${product.quantity}"),
                    trailing: Text("\$${product.discountedTotal}"),
                  );
                }).toList(),
              ),
            );
          },
        );
      }),
    );
  }
}
