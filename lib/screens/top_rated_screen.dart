import 'package:flutter/material.dart';
import 'package:movieflix/screens/movie_details_screen.dart';
import 'package:movieflix/services/api_services.dart';
import 'package:movieflix/services/search_method.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  _TopRatedScreenState createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  Future<void> _refreshMovies() async {
    await trFetchMovies();
    setState(() {
      // Update the state with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
        title: const Text(
          "Top Rated Movies",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: trFetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> movies = snapshot.data as List<dynamic>;
            return RefreshIndicator(
              onRefresh: _refreshMovies,
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final posterPath = movie['poster_path'];
                  final posterUrl =
                      'https://image.tmdb.org/t/p/w500$posterPath';
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    title: Text(
                      movies[index]['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Release Date: ${movie['release_date']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rating: ${movie['vote_average']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        posterUrl,
                        height: 150,
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
