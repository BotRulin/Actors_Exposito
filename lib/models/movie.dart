import 'dart:convert';

class Movie 
{
  int id;
  String title;
  String overview;
  String posterPath;
  String releaseDate;
  //List<int> moviesIds;
  Movie
  ({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    //required this.moviesIds,
  });

  factory Movie.fromMap(Map<String, dynamic> map) 
  {
    return Movie
    (
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      //popularity: map['popularity']?.toDouble() ?? 0.0,
      //moviesIds: List<int>.from(map['genre_ids']),
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}

