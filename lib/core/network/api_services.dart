import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/model/user_model.dart';

part 'api_services.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('users')
  Future<List<User>> getUsers();
}
