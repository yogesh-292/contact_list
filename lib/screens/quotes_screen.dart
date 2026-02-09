import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quotes_controller.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuotesController quotesController = Get.find<QuotesController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Obx(() {
        if (quotesController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (quotesController.quotes.isEmpty) {
          return const Center(
            child: Text('No quotes available', style: TextStyle(fontSize: 16)),
          );
        }
        return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final quote = quotesController.quotes[index];

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quote.quote,
                        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '--${quote.author}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: quotesController.quotes.length);
      }),
    );
  }
}
