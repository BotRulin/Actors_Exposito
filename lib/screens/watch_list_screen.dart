import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/api/api.dart';
import '/controllers/bottom_navigator_controller.dart';
import '/controllers/actors_controller.dart';
import '/screens/details_screen.dart';
import '/widgets/infos.dart';

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Obx(() => SingleChildScrollView
    (
          child: Padding
          (
            padding: const EdgeInsets.all(34.0),
            child: Column
            (
              children: 
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: 
                  [
                    IconButton
                    (
                      tooltip: 'Back to home',
                      onPressed: () => Get.find<BottomNavigatorController>().setIndex(0),
                      icon: const Icon
                      (
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text
                    (
                      'Watch list',
                      style: TextStyle
                      (
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox
                    (
                      width: 33,
                      height: 33,
                    ),
                  ],
                ),
                const SizedBox
                (
                  height: 20,
                ),
                if (Get.find<actorsController>().watchListActors.isNotEmpty)
                  ...Get.find<actorsController>().watchListActors.map
                  (
                        (actor) => Column
                        (
                          children: 
                          [
                            GestureDetector
                            (
                              onTap: () => Get.to(DetailsScreen(actor: actor)),
                              child: Row
                              (
                                mainAxisSize: MainAxisSize.min,
                                children: 
                                [
                                  ClipRRect
                                  (
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network
                                    (
                                      Api.imageBaseUrl + actor.profilePath,
                                      height: 180,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon
                                      (
                                        Icons.broken_image,
                                        size: 120,
                                      ),
                                      loadingBuilder: (_, __, ___) 
                                      {
                                        if (___ == null) return __;
                                        return const FadeShimmer
                                        (
                                          width: 120,
                                          height: 180,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox
                                  (
                                    width: 20,
                                  ),
                                  Infos(actor: actor)
                                ],
                              ),
                            ),
                            const SizedBox
                            (
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                if (Get.find<actorsController>().watchListActors.isEmpty)
                  const Column
                  (
                    children: 
                    [
                      SizedBox
                      (
                        height: 200,
                      ),
                      Text(
                        'No movies in your watch list',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
