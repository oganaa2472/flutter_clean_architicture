import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/features/users/domain/entities/user.dart';
import 'package:my_app/core/failures.dart';
import 'package:my_app/features/users/domain/repositories/user_repo.dart';
import 'package:my_app/features/users/domain/usercases/get_users.dart';

class MockGetUsersRepo extends Mock implements UserRepository {

}

void main() {
  late GetUsers getUsers;
  late MockGetUsersRepo mockGetUsersRepo;

  setUp(() {
    mockGetUsersRepo = MockGetUsersRepo();
    getUsers = GetUsers(mockGetUsersRepo);
  });

  test('should get users from the repository', () async {
    // arrange
  when(() => mockGetUsersRepo.getUsers())
    .thenAnswer((_) async => Right<Failure, List<User>>(<User>[]));
    // act
    final result = await getUsers();
    // assert: prefer checking isRight and then the right value to avoid
    // equality quirks with Either implementations
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Expected Right but got Failure: $l'),
      (r) => expect(r, <User>[]),
    );

    verify(() => mockGetUsersRepo.getUsers()).called(1);
    verifyNoMoreInteractions(mockGetUsersRepo);
  });
}