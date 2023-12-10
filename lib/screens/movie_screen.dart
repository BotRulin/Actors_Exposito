import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: const Color(0xFF242a32),
      appBar: AppBar
      (
        title: Text(movie.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF242a32),
      ),
      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            ClipRRect
            (
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network
              (
                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                width: double.infinity, // Ancho de la imagen
                height: 200, // Alto de la imagen
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text
            (
              'Title: ${movie.title}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text('Overview: ${movie.overview}', style: const TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            Text('Release Date: ${movie.releaseDate}', style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
