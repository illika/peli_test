import 'package:flutter/material.dart';

import 'package:app_peli/providers/movies_provider.dart';
import 'package:app_peli/search/search_delegate.dart';
import 'package:app_peli/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas en Cine"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovie),
            MovieSlider(
              movies: moviesProvider.onPopularMovie,
              title: "Poulares",
              onNextPage: () => moviesProvider.getOnPoularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}
