import 'package:cinema_house/core/locator.dart';
import 'package:cinema_house/features/comments/cubit/comments_cubit.dart';
import 'package:cinema_house/features/comments/domain/entities/comment_entity.dart';
import 'package:cinema_house/features/user/cubit/user_cubit.dart';
import 'package:cinema_house/features/user/domain/user_repository.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_form.dart';

class CommentsSection extends StatelessWidget {
  final int movieId;

  const CommentsSection(this.movieId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(locator<UserRepository>()),
      child: Column(
        children: [
          const Text("Comments section", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 15),
          BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
              if (state.status == CommentsStatus.loading) {
                return const Loader();
              }
              return Column(
                children: [
                  CommentForm(movieId),
                  const SizedBox(height: 15),
                  Column(
                      children: state.comments.map(_buildCommentTile).toList()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(CommentEntity comment) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final bool isMe = state.userName == comment.author;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
              tileColor: Colors.black12,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Anonymous"),
                  if (isMe) const Text("(Me)"),
                ],
              ),
              title: Text(comment.content),
              subtitle: Row(children: [
                Text(comment.rating.toString()),
                const SizedBox(width: 5),
                const Icon(Icons.star, size: 14),
              ]),
              trailing: (isMe)
                  ? IconButton(
                      icon: const Icon(Icons.delete_forever),
                      onPressed: () => BlocProvider.of<CommentsCubit>(context)
                          .removeComment(comment))
                  : null),
        );
      },
    );
  }
}
