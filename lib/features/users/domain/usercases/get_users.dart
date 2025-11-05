import 'package:dartz/dartz.dart';
import 'package:my_app/core/failures.dart';
import 'package:my_app/features/users/domain/entities/user.dart';
import 'package:my_app/features/users/domain/repositories/user_repo.dart';

class GetUsers {
  final UserRepository repository;
  GetUsers(this.repository);

  Future<Either<Failure, List<User>>> call() {
    return repository.getUsers();
  }
}
