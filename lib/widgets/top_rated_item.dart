import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/api/api.dart';
import '/models/actor.dart';
import '/screens/details_screen.dart';
import '/widgets/index_number.dart';

class TopRatedItem extends StatelessWidget 
{
  const TopRatedItem
  ({
    Key? key,
    required this.actor,
    required this.index,
  }) : super(key: key);

  final Actor actor;
  final int index;
  @override
  Widget build(BuildContext context) 
  {
    return Stack
    (
      children: 
      [
        GestureDetector
        (
          onTap: () => Get.to
          (
            DetailsScreen(actor: actor),
          ),
          child: Container
          (
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect
            (
              borderRadius: BorderRadius.circular(16),
              child: Image.network
              (
                Api.imageBaseUrl + actor.profilePath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => const Icon
                (
                  Icons.broken_image,
                  size: 180,
                ),
                loadingBuilder: (_, __, ___) {
                  if (___ == null) return __;
                  return const FadeShimmer
                  (
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        Align
        (
          alignment: Alignment.bottomLeft,
          child: IndexNumber(number: index),
        )
      ],
    );
  }
}
