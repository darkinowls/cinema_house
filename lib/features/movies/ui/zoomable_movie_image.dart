import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../data/models/movie_model.dart';
import '../repositories/entities/movie_entity.dart';

class ZoomableMovieImage extends StatelessWidget {
  const ZoomableMovieImage({
    super.key,
    required this.heroTag,
    required this.movie,
  });

  final String heroTag;
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
      imageProvider: CachedNetworkImageProvider(movie.image),
    );
  }
}
