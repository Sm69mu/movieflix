import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movieflix/screens/movie_details_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String searchApiUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear_outlined),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    if (query.isEmpty) {
      return Container(); // No results to display
    }

    return FutureBuilder(
      future: _searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> matchQuery =
              snapshot.data as List<Map<String, dynamic>>? ?? [];
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                title: Text(result['title']),
                onTap: () {
                  // Navigate to MovieDetailsScreen when a search result is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(movie: result),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> _searchMovies(String query) async {
    final response = await http.get(Uri.parse('$searchApiUrl&query=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Map<String, dynamic>> movies = results
          .map((movie) => {
                'title': movie['title'].toString(),
                'overview': movie['overview'].toString(),
                'poster_path': movie['poster_path'].toString(),
                'vote_average': movie['vote_average'],
                'runtime': movie['runtime'],
                // Add other fields you may need
              })
          .toList();

      return movies;
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
