import 'package:dartz/dartz.dart';
import 'package:my_app/core/failures.dart';
import 'package:my_app/features/users/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  
}