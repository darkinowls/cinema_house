import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/core/locator.dart';
import 'package:cinema_house/features/comments/cubit/comments_cubit.dart';
import 'package:cinema_house/features/comments/domain/entities/comment_entity.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_form.dart';

class CommentsSection extends StatelessWidget {
  final int movieId;

  const CommentsSection(this.movieId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(LocaleKeys.commentsSection.tr(), style: TextStyle(fontSize: 18)),
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
                (state.comments.isEmpty)
                    ? Text(LocaleKeys.noCommentsBeTheFirstOne.tr(),)
                    : Column(
                        children: state.comments
                            .map((comment) =>
                                _buildCommentTile(context, comment))
                            .toList()),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCommentTile(BuildContext context, CommentEntity comment) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
            tileColor: Colors.black12,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.anonymous.tr(),),
                if (comment.isMy!) Text(LocaleKeys.me.tr(),),
              ],
            ),
            title: Text(comment.content),
            subtitle: Row(children: [
              Text(comment.rating.toString()),
              const SizedBox(width: 5),
              const Icon(Icons.star, size: 14),
            ]),
            trailing: (comment.isMy!)
                ? IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () => BlocProvider.of<CommentsCubit>(context)
                        .removeComment(comment))
                : null));
  }
}
