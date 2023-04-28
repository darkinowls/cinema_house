import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/movie.dart';
import 'movie_details_screen.dart';

class VerticalMovieListView extends StatelessWidget {
  final Iterable<Movie> movies;
  final bool showCounter;

  const VerticalMovieListView(
      {super.key, required this.movies, this.showCounter = false});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(25),
      itemCount: movies.length,
      itemBuilder: (_, index) {
        String heroTag = const Uuid().v4();
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MovieDetailsScreen(
                        heroTag: heroTag, movie: movies.elementAt(index))));
          },
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCounter)
                SizedBox(width: 25, child: Text((index + 1).toString())),
              if (showCounter) const SizedBox(width: 5),
              Hero(
                tag: heroTag,
                child: CachedNetworkImage(imageUrl:movies.elementAt(index).smallImage),
              )
            ],
          ),
          title: Text(movies.elementAt(index).name),
          subtitle: Row(
            children: [
              Text(movies.elementAt(index).rating),
              const Icon(Icons.star, size: 14),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}