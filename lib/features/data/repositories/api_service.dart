import 'package:cv_d_project/features/data/models/users_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;
  @GET('users')
  Future<List<UsersModel>> getUsers();
}

// class ApiServerce {
//   final Dio dio = Dio();

//   Future<List<UsersModel>> getUsers() async {
//     try {
//       Response response = await dio.get(
//         'https://jsonplaceholder.typicode.com/users',
//       );
//       if (response.statusCode == 200) {
//         List<UsersModel> users =
//             (response.data as List)
//                 .map((user) => UsersModel.fromJson(user))
//                 .toList();
//         return users;
//       } else {
//         throw Exception('Failed to load users');
//       }
//     } catch (e) {
//       throw Exception('Failed to load users: $e');
//     }
//   }
// }
