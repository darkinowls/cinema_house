import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/features/comments/cubit/comments_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentForm extends StatefulWidget {
  final int movieId;

  const CommentForm(this.movieId, {Key? key}) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  late final TextEditingController _commentEditingController;
  int _rating = 4;

  @override
  void initState() {
    _commentEditingController = TextEditingController();
    _commentEditingController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          TextField(
            controller: _commentEditingController,
            decoration:
            InputDecoration(hintText: LocaleKeys.writeYourAnonymousComment.tr() ),
            maxLength: 120,
            minLines: 1,
            maxLines: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingBar.builder(
                  initialRating: 4,
                  itemSize: 18,
                  itemBuilder: (_, __) => const Icon(Icons.star),
                  onRatingUpdate: (rating) =>
                      setState(() => _rating = rating.toInt())),
              ElevatedButton(
                  onPressed: (_commentEditingController.text.isEmpty)
                      ? null
                      : () => BlocProvider.of<CommentsCubit>(context)
                          .addComment(
                              rating: _rating,
                              content: _commentEditingController.text,
                              movieId: widget.movieId),
                  child: Text(LocaleKeys.submit.tr()) )
            ],
          ),
        ],
      ),
    );
  }
}
