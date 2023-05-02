import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_house/features/comments/cubit/comments_cubit.dart';
import 'package:cinema_house/features/movies/ui/zoomable_movie_image.dart';
import 'package:cinema_house/features/sessions/cubit/sessions/sessions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/locator.dart';
import '../../../comments/data/repositories/i_comments_repository.dart';
import '../../../comments/widgets/comments_section.dart';
import '../../../sessions/domain/repositories/sessions_repository.dart';
import '../../../sessions/ui/horizontal_session_list_view.dart';
import '../../../sessions/ui/sessions_section.dart';
import '../../data/models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final String heroTag;

  const MovieDetailsScreen(
      {Key? key, required this.movie, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentsCubit>(
          create: (context) => CommentsCubit(locator<ICommentsRepository>()),
        ),
        BlocProvider<SessionsCubit>(
          create: (context) =>
              SessionsCubit(locator<SessionsRepository>(), movie.id),
        ),
      ],
      child: _ScrollableMovieDetailsScreen(movie: movie, heroTag: heroTag),
    );
  }
}

class _ScrollableMovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final String heroTag;

  const _ScrollableMovieDetailsScreen(
      {Key? key, required this.movie, required this.heroTag})
      : super(key: key);

  @override
  State<_ScrollableMovieDetailsScreen> createState() =>
      _ScrollableMovieDetailsScreenState();
}

class _ScrollableMovieDetailsScreenState
    extends State<_ScrollableMovieDetailsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(_scrollListener);
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<CommentsCubit>(context).loadComments(widget.movie.id);
      _scrollController.removeListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.movie.name,
              maxLines: 1, overflow: TextOverflow.ellipsis),
          actions: [
            IconButton(
                onPressed: () => Share.share(
                    'I would like to watch ${widget.movie.name} in Cinema House'),
                icon: const Icon(Icons.share))
          ]),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      widget.movie.image,
                    ),
                    fit: BoxFit.fill),
              ),
              padding: const EdgeInsets.all(25),
              height: 400,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: Hero(
                      tag: widget.heroTag,
                      child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ZoomableMovieImage(
                                      heroTag: widget.heroTag,
                                      movie: widget.movie))),
                          child: CachedNetworkImage(
                              imageUrl: widget.movie.image))),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Original name: ${widget.movie.originalName}"),
                  const SizedBox(height: 5),
                  Text("Language: ${widget.movie.language}"),
                  const SizedBox(height: 5),
                  Text("Genres: ${widget.movie.genre}"),
                  const SizedBox(height: 5),
                  Text("Country: ${widget.movie.country}"),
                  const SizedBox(height: 5),
                  Text("Director: ${widget.movie.director}"),
                  const SizedBox(height: 5),
                  Text("Duration: ${widget.movie.duration} minutes"),
                  const SizedBox(height: 5),
                  Text("Recomended age: ${widget.movie.age}"),
                  const SizedBox(height: 5),
                  Text("Main roles: ${widget.movie.starring}"),
                  const SizedBox(height: 5),
                  Text("Studio: ${widget.movie.studio}"),
                  const SizedBox(height: 5),
                  Text("Release year: ${widget.movie.year}"),
                  const SizedBox(height: 5),
                  // Text("Release year: ${movie.trailer}"),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () =>
                            launchUrl(Uri.parse(widget.movie.trailer)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.play_arrow),
                            Text("Trailer on YouTube"),
                          ],
                        )),
                  ),

                  const SizedBox(height: 5),
                  Text("Plot: ${widget.movie.plot}"),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const SessionsSection(),
            const SizedBox(height: 25),
            CommentsSection(widget.movie.id),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
