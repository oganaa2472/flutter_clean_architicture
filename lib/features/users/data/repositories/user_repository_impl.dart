
import 'package:dartz/dartz.dart';
import 'package:my_app/core/exceptions.dart';
import 'package:my_app/core/failures.dart';
import 'package:my_app/features/users/data/datasources/user_remote_data_source.dart';
import 'package:my_app/features/users/domain/entities/user.dart';
import 'package:my_app/features/users/domain/repositories/user_repo.dart';  

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try { 
      final users = await remoteDataSource.getUsers();
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}