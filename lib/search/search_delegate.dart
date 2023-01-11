import 'package:app_peli/models/models.dart';
import 'package:app_peli/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  /*
  recibir una Funcion ojo
   */

  @override
  String? get searchFieldLabel => "Buscar";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty || query.trim().isEmpty) return _contenedorVacio();
    return _mostrarPeliculas(context);
  }

  Widget _contenedorVacio() {
    return const Center(
      child: Icon(Icons.movie_outlined, size: 100, color: Colors.black45),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query.trim().isEmpty) return _contenedorVacio();
    return _mostrarPeliculas(context);
  }

  StreamBuilder<List<Movie>> _mostrarPeliculas(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    movieProvider.getSuggestionsByQuery(query.trim());

    return StreamBuilder(
      stream: movieProvider.listMovies,
      builder: (_, snapshot) {
        if (!snapshot.hasData) return _contenedorVacio();

        final movie = snapshot.data!;
        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (_, index) {
            return _MovieItem(movie: movie[index]);
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = "search-delegate-${movie.id}";
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage("assets/no-image.jpg"),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title ?? "-"),
      subtitle: Text(movie.originalTitle ?? "-"),
      onTap: () => Navigator.pushNamed(
        context,
        "details",
        arguments: movie,
      ),
    );
  }
}
