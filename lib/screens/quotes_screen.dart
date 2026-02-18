import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quotes_controller.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final QuotesController quotesController = Get.find<QuotesController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Quotes'), centerTitle: true, backgroundColor: Colors.grey),
      body: Obx(() {
        if (quotesController.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (quotesController.quotes.isEmpty) {
          return const Center(child: Text('No quotes available', style: TextStyle(fontSize: 16)));
        }
        return ListView.separated(
          padding: EdgeInsets.all(width * 0.04),
          itemBuilder: (context, index) {
            final quote = quotesController.quotes[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.03)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote.quote,
                      style: TextStyle(fontSize: width * 0.04, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: width * 0.03),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '--${quote.author}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: width * 0.03),
          itemCount: quotesController.quotes.length,
        );
      }),
    );
  }
}
