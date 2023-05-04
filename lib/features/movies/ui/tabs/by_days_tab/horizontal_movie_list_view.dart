import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_house/features/movies/cubit/movies/movies_cubit.dart';
import 'package:cinema_house/features/movies/repositories/movies_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/locator.dart';
import '../../../cubit/movie/movie_cubit.dart';
import '../../../data/models/movie.dart';
import '../../screens/movie_details_screen.dart';

class HorizontalMovieListView extends StatelessWidget {
  final Iterable<Movie> movies;

  const HorizontalMovieListView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        String heroTag = const Uuid().v4();
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider<MovieCubit>(
                      create: (_) => MovieCubit(
                        movies.elementAt(index),
                        locator<MoviesRepository>()
                      ),
                      child: MovieDetailsScreen(heroTag: heroTag),
                    )));
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
              width: 160,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: heroTag,
                        transitionOnUserGestures: true,
                        child: CachedNetworkImage(
                          imageUrl: movies.elementAt(index).smallImage,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(movies.elementAt(index).name,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Text(movies.elementAt(index).genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(movies.elementAt(index).rating),
                        const Icon(Icons.star, size: 14),
                      ],
                    )
                  ])),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 10),
    );
  }
}
