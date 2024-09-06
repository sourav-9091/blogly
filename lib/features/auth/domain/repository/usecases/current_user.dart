import 'package:blog_firebase/core/error/failure.dart';
import 'package:blog_firebase/core/usecase/usecase.dart';
import 'package:blog_firebase/core/common/entities/user.dart';
import 'package:blog_firebase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

class NoParams {}
