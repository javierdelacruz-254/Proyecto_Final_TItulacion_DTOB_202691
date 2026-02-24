import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:lactaamor/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:lactaamor/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lactaamor/features/auth/domain/repositories/auth_repository.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/login_user_withgoogle_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:lactaamor/features/auth/domain/usecases/reset_password_user_usecase.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final googleSignProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn.instance,
);

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(
    ref.read(firebaseAuthProvider),
    ref.read(firebaseFirestoreProvider),
    ref.read(googleSignProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDatasourceProvider));
});

final loginUserProvider = Provider<LoginUserUsecase>((ref) {
  return LoginUserUsecase(ref.read(authRepositoryProvider));
});

final registerUserProvider = Provider<RegisterUserUsecase>((ref) {
  return RegisterUserUsecase(ref.read(authRepositoryProvider));
});

final logoutUserProvider = Provider<LogoutUserUsecase>((ref) {
  return LogoutUserUsecase(ref.read(authRepositoryProvider));
});

final loginWithGoogleProvider = Provider<LoginUserWithgoogleUsecase>((ref) {
  return LoginUserWithgoogleUsecase(ref.read(authRepositoryProvider));
});

final sendResetLinkProvider = Provider<SendResetLinkUseCase>((ref) {
  return SendResetLinkUseCase(ref.read(authRepositoryProvider));
});

final checkActionCodeProvider = Provider<CheckActionUseCase>((ref) {
  return CheckActionUseCase(ref.read(authRepositoryProvider));
});

final confirmResetProvider = Provider<ConfirmResestUseCase>((ref) {
  return ConfirmResestUseCase(ref.read(authRepositoryProvider));
});
