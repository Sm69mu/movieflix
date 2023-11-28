import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  final dynamic movie;
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(_getTitle())),
      body: Stack(
        children: [
          SizedBox(
            height: deviceHeight,
            child: Image.network(
              _getPosterPath(),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(235, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title: ${_getTitle()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rating: ${_getRating()}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Runtime: ${_getRuntime()} minutes',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getOverview(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getTitle() {
    if (movie is Map<String, dynamic>) {
      return movie['title'];
    } else if (movie is String) {
      return movie;
    } else {
      return 'Unknown Title';
    }
  }

  String _getOverview() {
    if (movie is Map<String, dynamic>) {
      return movie['overview'];
    } else {
      return 'No overview available';
    }
  }

  String _getPosterPath() {
    if (movie is Map<String, dynamic>) {
      return 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
    } else {
      return '';
    }
  }

  String _getRating() {
    if (movie is Map<String, dynamic>) {
      return movie['vote_average'].toString();
    } else {
      return 'N/A';
    }
  }

  int _getRuntime() {
    if (movie is Map<String, dynamic>) {
      return movie['runtime'] ?? 0;
    } else {
      return 0;
    }
  }
}
