import 'package:app_peli/models/models.dart';
import 'package:app_peli/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _CustomPosterAndTitle(movie: movie),
                _CustomOverview(movie: movie),
                CastingCard(movieId: movie.id!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          color: Colors.black26,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          alignment: Alignment.bottomCenter,
          child: Text(
            movie.title ?? "-",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _CustomPosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _CustomPosterAndTitle({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? "-",
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle ?? "-",
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.stars_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${movie.voteAverage ?? "-"}",
                      style: textTheme.caption,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomOverview extends StatelessWidget {
  final Movie movie;
  const _CustomOverview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview ?? "-",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
