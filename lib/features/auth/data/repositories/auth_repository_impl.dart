import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lactaamor/features/auth/data/models/user_model.dart';
import 'package:lactaamor/features/auth/domain/entities/user_entity.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<UserEntity> login(String email, String password) {
    return remoteDatasource.loginUser(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<UserEntity> register(UserEntity user, String password) {
    return remoteDatasource.registerUser(user as UserModel, password);
  }

  @override
  Future<UserEntity> loginWithGoogle() {
    return remoteDatasource.loginWithGoogle();
  }

  @override
  Future<bool> checkActionCode(String oobCode) {
    return remoteDatasource.checkActionCode(oobCode);
  }

  @override
  Future<void> confirmReset({
    required String oobCode,
    required String newPassword,
  }) {
    return remoteDatasource.confirmReset(
      oobCode: oobCode,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> sendResetLink(String email) {
    return remoteDatasource.sendResetLink(email);
  }
}
