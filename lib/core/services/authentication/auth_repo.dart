import 'package:mediplus/core/services/authentication/model/user_model.dart';

abstract class AuthRepository {
  registerUser(UserModel payload);
}
