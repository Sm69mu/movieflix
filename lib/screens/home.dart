import 'package:flutter/material.dart';
import 'package:movieflix/screens/now_playing_screen.dart';
import 'package:movieflix/screens/top_rated_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pages = [const NowPlayingScreen(), const TopRatedScreen()];

    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.movie_creation_outlined), label: "Now Playing"),
          NavigationDestination(
              icon: Icon(Icons.star_border_outlined), label: "Top Rated"),
        ],
      ),
    );
  }
}
