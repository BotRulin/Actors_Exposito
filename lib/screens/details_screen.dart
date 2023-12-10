import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/api/api.dart';
import '/api/api_service.dart';
import '/controllers/actors_controller.dart';

import '/models/actor.dart';
import '/models/review.dart';
import '/utils/utils.dart';

import '../models/movie.dart';
import 'movie_screen.dart';

class DetailsScreen extends StatelessWidget 
{
  const DetailsScreen
  ({
    Key? key,
    required this.actor,
  }) : super(key: key);
  final Actor actor;
  @override
  Widget build(BuildContext context) 
  {
    ApiService.getActorsReviews(actor.id);

    return SafeArea
    (
      child: Scaffold
      (
        body: SingleChildScrollView
        (
          child: Column
          (
            children: 
            [
              Padding
              (
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: 
                  [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon
                      (
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text
                    (
                      'Detail',
                      style: TextStyle
                      (
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip
                    (
                      message: 'Save this actor to your favourite list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton
                      (
                        onPressed: () 
                        {
                          Get.find<actorsController>().addToWatchList(actor);
                        },
                        icon: Obx
                        (() =>
                              Get.find<actorsController>().isInWatchList(actor)
                                  ? const Icon
                                  (
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 33,
                                  )
                                  : const Icon
                                  (
                                    Icons.bookmark_outline,
                                    color: Colors.white,
                                    size: 33,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox
              (
                height: 40,
              ),
              SizedBox
              (
                height: 330,
                child: Stack
                (
                  children: 
                  [
                    ClipRRect
                    (
                      borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image.network
                    (
                      Api.imageBaseUrl + actor.profilePath,
                      width: Get.width,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, __, ___) 
                      {
                        if (___ == null) return __;
                        return FadeShimmer
                        (
                          width: Get.width,
                          height: 250,
                          highlightColor: const Color(0xff22272f),
                          baseColor: const Color(0xff20252d),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Align
                      (
                        alignment: Alignment.center,
                        child: Icon
                        (
                          Icons.broken_image,
                          size: 250,
                        ),
                      ),
                    ),
                  ),
                  Container
                  (
                    margin: const EdgeInsets.only(left: 30),
                    child: Align
                    (
                      alignment: Alignment.bottomLeft,
                      child: ClipRRect
                      (
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network
                        (
                          'https://image.tmdb.org/t/p/w500/${actor.profilePath}',
                          width: 110,
                          height: 140,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, __, ___) 
                          {
                            if (___ == null) return __;
                            return const FadeShimmer
                            (
                              width: 110,
                              height: 140,
                              highlightColor: Color(0xff22272f),
                              baseColor: Color(0xff20252d),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned
                  (
                    top: 255,
                    left: 155,
                    child: SizedBox
                    (
                      width: 230,
                      child: Text
                      (
                        actor.name,
                        style: const TextStyle
                        (
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned
                  (
                    top: 200,
                    right: 30,
                    child: Container
                    (
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration
                      (
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromRGBO(37, 40, 54, 0.52),
                      ),
                      child: Row
                      (
                        children: 
                        [
                          SvgPicture.asset('assets/Star.svg'),
                          const SizedBox
                          (
                            width: 5,
                          ),
                          Text
                          (
                            actor.popularity == 0.0? 'N/A': actor.popularity.toString(),
                            style: const TextStyle
                            (
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFF8700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox
            (
              height: 25,
            ),
            Opacity
            (
              opacity: .6,
              child: SizedBox
              (
                width: Get.width / 1.8,
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: 
                  [
                    Row
                    (
                      children: 
                      [
                        SvgPicture.asset('assets/calender.svg'),
                        const SizedBox
                        (
                          width: 5,
                        ),
                        actor.birthday != null && actor.birthday.isNotEmpty? Text
                        (
                          actor.birthday,
                          style: const TextStyle
                          (
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white, 
                          ),
                        )
                        : Text
                        (
                          'No Birthday Found',
                          style: const TextStyle
                          (
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white, 
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.all(24),
              child: DefaultTabController
              (
                length: 2,
                child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  children: 
                  [
                    const TabBar
                    (
                      indicatorWeight: 4,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color(0xFF3A3F47),
                      tabs: 
                      [
                        Tab(text: 'Biography'),
                        Tab(text: 'Cast'),
                      ],
                    ),
                    Container
                    (
                      height: 400,
                      child: TabBarView
                      (
                        children: 
                        [
                          FutureBuilder<Actor?>
                          (
                            future: ApiService.getActorsReviews(actor.id),
                            builder: (context, snapshot) 
                            {
                              if (snapshot.connectionState == ConnectionState.waiting) 
                              {
                                return Center(child: CircularProgressIndicator());
                              } 
                              else if (snapshot.hasError) 
                              {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } 
                              else if (snapshot.hasData) 
                              {
                                return SingleChildScrollView
                                (
                                  child: Padding
                                  (
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text
                                    (
                                      snapshot.data!.biography.isEmpty? 'No Biography Found': snapshot.data!.biography,
                                      style: const TextStyle
                                      (
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              } 
                              else 
                              {
                                return const Center(child: Text('Wait...'));
                              }
                            },
                          ),
                          FutureBuilder<List<Movie>>
                          (
                            future: ApiService.getActorMovies(actor.id),
                            builder: (context, snapshot) 
                            {
                              if (snapshot.connectionState == ConnectionState.waiting) 
                              {
                                return Center(child: CircularProgressIndicator());
                              } 
                              else if (snapshot.hasError) 
                              {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } 
                              else if (snapshot.hasData && snapshot.data!.isNotEmpty) 
                              {
                                return ListView.builder
                                (
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) 
                                  {
                                    final Movie movie = snapshot.data![index];
                                    return GestureDetector
                                    (
                                      onTap: () 
                                      {
                                        Navigator.push
                                        (
                                          context,
                                          MaterialPageRoute
                                          (
                                            builder: (context) => MovieDetailScreen(movie: movie),
                                            ),
                                        );
                                      },
                                      child: Container
                                      (
                                        margin: const EdgeInsets.all(8.0),
                                        width: 150, // Ancho de cada elemento de la lista
                                        child: Column
                                        (
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: 
                                          [
                                            ClipRRect
                                            (
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network
                                              (
                                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                                width: 150,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text
                                            (
                                              movie.title,
                                              style: TextStyle
                                              (
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } 
                              else 
                              {
                                return Center(child: Text('No movies found for this actor.'));
                              }
                            },
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
