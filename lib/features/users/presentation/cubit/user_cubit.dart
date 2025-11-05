import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/users/domain/entities/user.dart';
import 'package:my_app/features/users/domain/usercases/get_users.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.getUsersUseCase}) : super(UserInitial());
  final GetUsers getUsersUseCase;
  Future<void> fetchUsers() async {
    emit(UserLoading());
    final result = await getUsersUseCase();
    result.fold(
      (failure) => emit(UserError('Failed to fetch users')),
      (users) => emit(UserLoaded(users)),
    );
  }
}
