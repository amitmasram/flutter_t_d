import 'package:cv_d_project/core/config/utils/text_string.dart';
import 'package:cv_d_project/core/theme/colors_theme.dart';
import 'package:cv_d_project/features/presentation/bloc/users_bloc.dart';
import 'package:cv_d_project/features/presentation/bloc/users_state.dart';
import 'package:cv_d_project/features/presentation/bloc/users_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: ColorsTheme.gradient),
        ),
        title: const Text(
          AppTextString.appbartitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final users = state.users;

          if (users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                            value: state.allSelected,
                            onChanged: (value) {
                              if (value == true) {
                                context.read<UserBloc>().add(SelectAllUsers());
                              } else {
                                context.read<UserBloc>().add(ResetSelections());
                              }
                            },
                          ),
                        ),
                        const Text(
                          AppTextString.selectall,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        context.read<UserBloc>().add(DeleteSelectedUsers());
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWell(
                        onTap: () {
                          context.read<UserBloc>().add(
                            ToggleUserSelection(index),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 60,
                          decoration: BoxDecoration(
                            color:
                                user.isSelected
                                    ? Colors.green.withOpacity(0.2)
                                    : const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(3),
                            border:
                                user.isSelected
                                    ? Border.all(
                                      color: Colors.green.shade300,
                                      width: 2.0,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    )
                                    : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                user.isSelected ? Icons.check_sharp : null,
                                size: 27,
                                color:
                                    user.isSelected
                                        ? Colors.green.shade400
                                        : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(ResetSelections());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2.0,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              AppTextString.reset,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(SubmitSelectedUsers());
                          showAboutDialog(
                            context: context,
                            children: [
                              Center(
                                child: const Text(
                                  'Users submitted successfully',
                                ),
                              ),
                            ],
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.lightBlue,
                          ),
                          child: const Center(
                            child: Text(
                              AppTextString.submitusers,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
