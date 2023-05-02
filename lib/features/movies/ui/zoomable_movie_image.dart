

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/models/movie.dart';

class ZoomableMovieImage extends StatelessWidget {
  const ZoomableMovieImage({
    super.key,
    required this.heroTag,
    required this.movie,
  });

  final String heroTag;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InteractiveViewer(
            panEnabled: false, // Set it to false to prevent panning.
            boundaryMargin: const EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            child: Hero(
                tag: heroTag,
                child: CachedNetworkImage(imageUrl: movie.image))));
  }
}
