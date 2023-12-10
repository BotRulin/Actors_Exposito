import 'dart:convert';
import '/api/api.dart';
import '/models/actor.dart';
import 'package:http/http.dart' as http;
import '/models/review.dart';

import '../models/movie.dart';

class ApiService 
{
  static Future<List<Actor>?> getTopRatedActors() async 
  {
    List<Actor> actors = [];
    try 
    {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach
      (
        (m) => actors.add
        (
          Actor.fromMap(m),
        ),
      );
      return actors;
    } 
    catch (e) 
    {
      return null;
    }
  }

  static Future<List<Actor>?> getCustomActors(String url) async 
  {
    List<Actor> actors = [];
    try 
    {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach
      (
            (m) => actors.add
            (
              Actor.fromMap(m),
            ),
          );
      return actors;
    } 
    catch (e) 
    {
      return null;
    }
  }

  static Future<List<Actor>?> getSearchedActors(String query) async 
  {
    List<Actor> actors = [];
    try 
    {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}/search/person?api_key=${Api.apiKey}&query=$query'));
      var res = jsonDecode(response.body);
      res['results'].forEach
      (
        (m) => actors.add
        (
          Actor.fromMap(m),
        ),
      );
      return actors;
    } 
    catch (e) 
    {
      return null;
    }
  }

  static Future<Actor?> getActorsReviews(int actorsId) async 
  {
    try 
    {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}/person/$actorsId?api_key=${Api.apiKey}'));
      var res = jsonDecode(response.body);

      return Actor
      (
        id: actorsId,
        name: res['name'],
        profilePath: res['profile_path'],
        biography: res['biography'],
        birthday: res['birthday'],
        popularity: res['popularity'].toDouble(),
      );
    } 
    catch (e) 
    {
      return null;
    }
  }


  static Future<List<Movie>> getActorMovies(int actorId) async
  {
    final response = await http.get(Uri.parse('${Api.baseUrl}/person/$actorId/movie_credits?api_key=${Api.apiKey}'));

    if (response.statusCode == 200) 
    {
      List<Movie> movies = [];

      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> moviesJson = data['cast'];

      for (var movieJson in moviesJson) 
      {
        Movie movie = Movie.fromMap(movieJson);
        movies.add(movie);
      }

      return movies;
    } 
    else 
    {
      throw Exception('Failed to load actor movies');
    }
  }
}
