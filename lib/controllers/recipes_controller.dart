import 'package:flutter_practice/core/app_imports.dart';

class RecipesController extends BaseController {
  final RxnString error = RxnString();

  final RxList<Recipe> recipes = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() {
    return executeApi(
      request: () => apiService.fetchRecipes(),
      showLoader: true,
      onSuccess: (data) {
        if (data == null) {
          error.value = "No data recieved";
          return;
        }
        debugPrint('the runtime type of the recipes data is ---> ${data.runtimeType}');

        if (data is RecipesResponse) {
          recipes.assignAll(data.recipes);

          Get.snackbar(
            "Success",
            "Recipies fetched successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
      },
      onError: (err) {
        debugPrint("Error while fetching recipes ----> $err");
        error.value = err.toString();
      },
    );
  }
}
