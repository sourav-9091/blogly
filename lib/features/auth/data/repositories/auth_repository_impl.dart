import 'package:blog_firebase/core/error/exception.dart';
import 'package:blog_firebase/core/error/failure.dart';
import 'package:blog_firebase/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_firebase/core/common/entities/user.dart' as usr;
import 'package:blog_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, usr.User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );

      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, usr.User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, usr.User>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(
          Failure('User is not logged in'),
        );
      }
      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
