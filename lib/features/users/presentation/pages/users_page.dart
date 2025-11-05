import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/users/presentation/cubit/user_cubit.dart';
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserCubit>().fetchUsers();
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return const Center(child: Text('Press button to load users'));
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final users = state.users;
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name!),
                    subtitle: Text(user.email!),
                    trailing: Text(user.username!),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<UserCubit>().fetchUsers(),
        child: const Icon(Icons.download),
      ),
    );
  }
}