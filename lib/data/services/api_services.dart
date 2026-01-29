import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/user_model.dart';

part 'api_services.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // convenience factory
  factory ApiService.create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
      ),
    );
    return ApiService(dio);
  }

  @GET('users')
  Future<List<User>> getUsers();
}
