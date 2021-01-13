import 'package:weight_tracker/src/datalayer/providers/auth_provider.dart';
import 'package:weight_tracker/src/models/user.dart';

class AuthRepository {
  AuthApiProvider authApiProvider = AuthApiProvider();

  Future<User> loginUser(User user) => authApiProvider.loginUser(user);

  Future<dynamic> registerUser(User user) => authApiProvider.registerUser(user);
}
