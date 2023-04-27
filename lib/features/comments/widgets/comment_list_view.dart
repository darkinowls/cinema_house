import 'package:cinema_house/features/comments/cubit/comments_cubit.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state.status == CommentsStatus.waiting) {
          return const SizedBox();
        }
        if (state.status == CommentsStatus.loading) {
          return const Loader();
        }
        return ListView.separated(
          itemCount: state.comments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (context, index) => ListTile(
            title: Column(
              children: [
                Text(state.comments.elementAt(index).author!),
                const SizedBox(height: 5),
                Text(state.comments.elementAt(index).content),
              ],
            ),
            subtitle: Text(state.comments.elementAt(index).rating.toString()),
          ),
        );
      },
    );
  }
}
