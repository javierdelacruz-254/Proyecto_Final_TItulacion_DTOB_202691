import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';
import 'package:lactaamor/features/auth/domain/entities/user.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> login(String email, String password) {
    return remoteDatasource.loginUser(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<User> register(User user, String password) {
    return remoteDatasource.registerUser(user as UserModel, password);
  }
}
