import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 레스토랑 이름
  final String name;
  // 레스토랑 태그
  final List<String> tags;
  // 평점 개수
  final int ratingCount;
  // 배송 걸리는 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 평균 평점
  final double rating;
  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: image,
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              tags.join(' · '),
            )
          ],
        )
      ],
    );
  }
}
