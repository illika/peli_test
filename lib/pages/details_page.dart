import 'package:app_peli/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "No-Movie";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _CustomPosterAndTitle(),
                _CustomOverview(),
                _CustomOverview(),
                _CustomOverview(),
                CastingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

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
          //color: Colors.black26,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "title.movie",
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://via.placeholder.com/500x300.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _CustomPosterAndTitle extends StatelessWidget {
  const _CustomPosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage(
                "https://via.placeholder.com/200x300.jpg",
              ),
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "title.movie",
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "original.title",
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
                    "movi.evote",
                    style: textTheme.caption,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CustomOverview extends StatelessWidget {
  const _CustomOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Donec lobortis, elit eget molestie eleifend, metus sapien sagittis lectus, vitae scelerisque magna mauris a est. Aliquam convallis condimentum ex ut dignissim. Etiam et tincidunt augue, in pretium mi. Phasellus eget urna vel metus commodo rhoncus interdum sed elit. In non vulputate ligula. Pellentesque quis eros eu dui venenatis faucibus eget sit amet mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent eu eleifend quam. Vestibulum consequat egestas lectus, eget tristique felis malesuada eget. Nullam venenatis ante in tellus porttitor molestie a ac ex.",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
