import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> npFetchMovies() async {
  final response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<dynamic>> trFetchMovies() async {
  final response = await http.get(
    Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load movies');
  }
}

